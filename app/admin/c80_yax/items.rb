# категории строительных материалов
ActiveAdmin.register C80Yax::Item, as: 'Item' do

  menu :label => proc{ I18n.t('c80_yax.active_admin.menu.item')},
       :parent => 'x_c80_yax',
       :priority => 2


  permit_params :title,
                :short_desc,
                :full_desc,
                :is_hit,
                :is_sale,
                :is_main,
                :is_gift,
                :is_starting,
                :is_available,
                :strsubcat_id#,
                # :item_props_attributes => [:value, :_destroy, :prop_name_id, :id],
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

    column :title
    # column :is_hit
    # column :is_sale
    # column :is_main
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

  form(:html => {:multipart => true}) do |f|

    f.inputs "Свойства" do
      f.input :title
      f.input :strsubcat,
              :as => :select,
              :collection => C80Yax::Strsubcat.all.map { |s| [s.title,s.id] },
              :input_html => {
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

      f.input :short_desc, :input_html => {:style => 'height:80px'}
      f.input :full_desc, :as => :ckeditor, :input_html => {:style => 'height:500px', rows: 20}
      # f.input :vendors, :as => :select, :input_html => {:multiple => false}, :include_blank => true

      # f.input :image,
      #          :as => :file,
      #          :hint => image_tag(f.object.image.thumb_fit)
    end

    # f.inputs "Характеристики" do
    #
    #   f.has_many :item_props, :allow_destroy => true do |item_prop|
    #       item_prop.input :prop_name
    #       item_prop.input :value
    #   end
    #
    # end

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