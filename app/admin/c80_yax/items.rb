# категории строительных материалов
ActiveAdmin.register C80Yax::Item, as: 'Item' do

  menu :label => proc {I18n.t('c80_yax.active_admin.menu.item')},
       :parent => 'x_c80_yax',
       :priority => 3


  permit_params :title,
                :short_desc,
                :full_desc,
                :is_hit,
                :is_sale,
                :is_main,
                :is_gift,
                :is_starting,
                :is_available,
                :strsubcat_id,
                :iphotos_attributes => [:id, :image, :_destroy],
                :item_props_attributes => [:value, :_destroy, :prop_name_id, :id] #,
  # :vendor_ids => [],
  # :gallery_ids => [],
  # :related_child_ids => []

  config.sort_order = 'id_asc'

  # controller do
  #   cache_sweeper :item_sweeper, :only => [:update,:create,:destroy]
  # end

  # action_item :dublcate_item, :only => :edit do
  #     link_to 'Клонировать', '', class:'dublicate_item'#, method: :post # эта ссылка обработается ajax-ом
  # end

  index do
    selectable_column
    id_column

    column :iphotos do |item|
      r = ''
      if item.iphotos.count > 0
        r = link_to image_tag(item.iphotos.first.image.thumb_md,
                              style: 'width:150px'),
                    item.iphotos.first.image.url,
                    target: '_blank'
        r = "#{r}<br>Всего фотографий: #{item.iphotos.count}".html_safe
      end
      r
    end

    column :title
    column :is_hit
    column :is_sale
    column :is_main
    # column :is_ask_price

    # column 'Бренд' do |itm|
    #   str = '-'
    #   if itm.vendors.count > 0
    #     str = itm.vendors.first.title
    #   end
    #   str
    # end

    actions
  end

  index as: :grid do |product|
    product
  end

  form(:html => {:multipart => true}) do |f|

    f.inputs 'Свойства' do
      f.input :title
      f.input :strsubcat,
              :as => :select,
              :collection => C80Yax::Strsubcat.all.map {|s| [s.title, s.id]},
              :input_html => {
                  :title => '',
                  :class => 'selectpicker',
                  :data => {
                      :size => 10
                  }
              }

      f.input :is_hit
      f.input :is_sale
      f.input :is_main
      f.input :is_gift
      f.input :is_starting
      f.input :is_available

      f.input :short_desc, :input_html => {:style => 'height:80px', :maxlength => 250}

      # Как поменять надпись на кнопке? Хочу убрать добавить Iphoto
      # http://stackoverflow.com/questions/9266496/translate-rails-model-association-not-working
      # http://stackoverflow.com/questions/8310997/configure-the-label-of-active-admin-has-many
      # https://github.com/justinfrench/formtastic
      f.has_many :iphotos, :allow_destroy => true do |iph|
        iph.input :image,
                  :as => :file,
                  :hint => image_tag(iph.object.image.thumb_md)
      end

      f.input :full_desc, :as => :ckeditor, :input_html => {:style => 'height:500px', rows: 20}
      # f.input :vendors, :as => :select, :input_html => {:multiple => false}, :include_blank => true


    end

    f.inputs 'Характеристики' do

      f.has_many :item_props, :allow_destroy => true do |item_prop|
        item_prop.input :prop_name
        item_prop.input :value
      end

    end

    # f.inputs "Укажите товары, которые будут выводиться в блоке 'Похожие товары'", :class => 'collapsed' do
    #   f.input :related_childs,
    #           :as => :check_boxes,
    #           :member_label => Proc.new { |p|
    #             p.title
    #           }
    # end

    f.actions
  end

end