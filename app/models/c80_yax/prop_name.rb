module C80Yax
  class PropName < ActiveRecord::Base

    validates :title,
              presence: true,
              uniqueness: true,
              length: { in: 2..150 }

    # has_many :item_props, :dependent => :destroy
    has_and_belongs_to_many :strsubcats
    belongs_to :uom
    accepts_nested_attributes_for :uom

    has_many :im_old_price_and_this_is_link_to_my_normal_price, # NOTE:: поправить, как дойдёт дело
             class_name: 'C80Yax::ItemProp',
             foreign_key: 'related_id'

    # для цены можно указать старую цену (если она есть)
    belongs_to :related,
               class_name: 'C80Yax::ItemProp'

    has_and_belongs_to_many :main_props
    has_and_belongs_to_many :common_props
    has_and_belongs_to_many :price_props

    default_scope {order(:title => :asc)}

    # validates_with PropNameValidator
    # TODO:: добавить валидацию title на уникальность и длину

  end
end