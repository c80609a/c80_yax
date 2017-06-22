require 'babosa'

class C80Yax::Item < ActiveRecord::Base

  validates :title,
            presence: true,
            uniqueness: true,
            length: { in: 2..150 }

  validates :strsubcat,
            presence: true

  has_and_belongs_to_many :vendors
  belongs_to :strsubcat

  has_many :iphotos, :dependent => :destroy
  accepts_nested_attributes_for :iphotos,
                                :reject_if => lambda { |attributes|
                                  !attributes.present?
                                },
                                :allow_destroy => true

  has_many :item_props, :dependent => :destroy
  accepts_nested_attributes_for :item_props,
                                :reject_if => lambda { |attributes|
                                  # puts "attributes:: #{attributes}"
                                  # attributes:: {"value"=>"", "prop_name_id"=>""}
                                  !attributes.present? || \
                                  !attributes[:value].present? || \
                                  !attributes[:prop_name_id].present?
                                },
                                :allow_destroy => true

  has_many :related_childs, :class_name => 'C80Yax::Item', :foreign_key => 'related_parent_id'
  belongs_to :related_parent, :class_name => 'C80Yax::Item'

  extend FriendlyId
  friendly_id :slug_candidates, :use => :slugged

  def slug_candidates
    [:title] + Array.new(6) {|index| [:title, index+2]}
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end




  # выдать все товары, которые надо показать на главной странице "строительные материалы"
  # с помощью методов ActiveRecord
  def self.all_on_main_ar

    # * В первую очередь отображаются товары с пометкой "Выводится на главной"
    items_is_main = self.where('is_main = ?',1)

    # * Далее во вторую очередь выводятся товары, у которых есть обе отметки "hit" и "sale"
    items_is_hit_and_is_sale = self.where('is_hit = ? AND is_sale = ?',1,1)

    # * Далее выводятся товары, которые отмечены только "hit"
    items_is_hit = self.where('is_hit = ? AND is_sale = ?',1,0)

    # * Потом товары, которые отмечены только sale
    items_is_sale = self.where('is_sale = ? AND is_hit = ?',1,0)

    # * А далее все товары, которые по цене (по возрастанию) - от наиболее дешевого товара к наиболее дорогому.
    items_other = self.where.not('is_main = ?',1)
                      .where.not('is_hit = ? AND is_sale = ?',1,1)
                      .where.not('is_hit = ?',1)
                      .where.not('is_sale = ?',1)

    items_is_main.union(items_is_hit_and_is_sale)
        .union(items_is_hit)
        .union(items_is_sale)
        .union(items_other)

  end

  # выдать все товары, которые надо показать на любой странице подкатегории (БЕЗ ФИЛЬТРОВ)
  # с помощью методов ActiveRecord и c80_active_record_union
  def self.all_on_subcat_ar(strsubcat_id)

    # Сначала выводятся только те, товары, у которых есть обе отметки "hit" и "sale"
    items_is_hit_and_is_sale = self.where('is_hit = ? AND is_sale = ?',1,1)

    # * Далее выводятся товары, которые отмечены только "hit"
    items_is_hit = self.where('is_hit = ? AND is_sale = ?',1,0)

    # * Потом товары, которые отмечены только sale
    items_is_sale = self.where('is_sale = ? AND is_hit = ?',1,0)

    # * А далее все товары, которые по цене (по возрастанию) - от наиболее дешевого товара к наиболее дорогому.
    items_other = self.where.not('is_main = ?',1)
                      .where.not('is_hit = ? AND is_sale = ?',1,1)
                      .where.not('is_hit = ?',1)
                      .where.not('is_sale = ?',1)

    items_is_hit_and_is_sale.union(items_is_hit)
        .union(items_is_sale)
        .union(items_other)
        .where(:strsubcat_id => strsubcat_id)

  end

  before_save :before_save_format_desc

  # сформировать и вернуть список "похожих товаров"
  def self.get_related_items_list(item_id)
    # Rails.logger.debug("<Item.get_related_items_list> [123] item_id = #{item_id}")
    # Он формируется по следующим правилам:
    # 1. Попадают товары из этой же подкатегории (обязательно, если в подкатегории один товар, то блока просто нет)
    # 2. Тот же бренд
    # 3. Наиболее близкая цена
    # 4. Если есть параметр "Размер", то наиболее близкие по размеру.
    # Также должа быть возможность ручного управления блоком "Похожие товары",
    # где администратор просто указывает ссылки на похожие товары.

    # результат
    all_related_items = []

    # кол-во элементов в результате не более этого значения
    n = 4

    item = self.find(item_id)

    if item.related_childs.count > 0
      item.related_childs.each do |itm|
        if all_related_items.count < n
          all_related_items << itm
        else
          break
        end
      end
    end

    all_related_items

  end

  private

  def before_save_format_desc
    if self.full_desc.present?
      v = self.full_desc

      # удаляем inline css стили
      v = v.gsub(/ style=["'][^"']+["']/, '')

      # удаляем тэг <font>
      v = v.gsub(/<font[^>]*>/, '')
      v = v.gsub('</font>', '')

      # <strong>...</strong> заменяем на <span class='bold'>...</span>
      v = v.gsub(/<(em|strong)>/, '<span class="bold">')
      v = v.gsub(/<\/(em|strong)>/, '</span>')

      # заголовки h1, h2, h3 заменяем на h4
      v = v.gsub(/<(h1|h2|h3)>/, '<h4>')
      v = v.gsub(/<\/(h1|h2|h3)>/, '<h4>')

      v = v.gsub('&nbsp;', ' ')

      self.full_desc = v
    end

  end

end
