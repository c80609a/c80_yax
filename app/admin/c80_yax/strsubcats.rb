# ПОДкатегории строительных материалов
ActiveAdmin.register C80Yax::Strsubcat, as: 'Strsubcat' do

  menu :label => proc{ I18n.t('c80_yax.active_admin.menu.strsubcat')},
       :parent => 'x_c80_yax',
       :priority => 2

  permit_params :title,
                :slug,
                :ord,
                :parent_id
                # :prop_name_ids => [],
                # :main_props_attributes => [:id, :_destroy, :prop_name_ids => []],
                # :common_props_attributes => [:id, :_destroy, :prop_name_ids => []],
                # :price_props_attributes => [:id, :_destroy, :prop_name_ids => []]

  config.sort_order = 'id_asc'

  # controller do
  #   cache_sweeper :strsubcat_sweeper, :only => [:update,:create,:destroy]
  # end

  # before_filter :skip_sidebar!, :only => :index

  filter :title
  filter :parent_id_in,
         :as => :select,
         :collection => -> { C80Yax::Strsubcat.all.map { |s| [s.title,s.id] }},
         :input_html => {
             :class => 'selectpicker',
             :data => {
                 :size => 10,
                 :width => '100%'
             }
         }

  # controller do
  #   cache_sweeper :suit_sweeper, :only => [:update,:create,:destroy]
  # end

  index do
    selectable_column
    id_column
    column :ord do |str_sub_cat|
      editable_text_column str_sub_cat, :ord
    end
    column :title
    column :parent

    # column :strcats do |str_sub_cat|
    #   str = '-'
    #   if str_sub_cat.strcats.count > 0
    #     str = str_sub_cat.strcats.first.title
    #   end
    #   str
    # end

    actions
  end

  form(:html => {:multipart => true}) do |f|

    f.inputs "Свойства подкатегории" do
      f.input :title
      f.input :ord
      f.input :parent,
              :as => :select,
              :collection => C80Yax::Strsubcat.where.not(id:f.object.id).map { |s| ["#{s.title}", s.id]},
              :input_html => {
                  :class => 'selectpicker',
                  :data => {
                      :size => '10',
                      :width => '400px'
                  },
                  :multiple => false
              },
              :include_blank => true
    end

    # f.inputs "Характеристики, которыми описываются товары из этой подкатегории", :class => 'collapsed' do
    #   f.input :prop_names, :as => :check_boxes
    # end

    # f.inputs "Характеристки, которые выводятся на странице просмотра товара справа от картинки (<a class='poiasn' href='#{image_url('samples/2015_11_22_item_main_props.jpg')}' target='_blank'>например</a>)", :class => 'collapsed-bug fieldset_main_props' do
    #   f.has_many :main_props, allow_destroy: true do |main_prop|
    #     main_prop.input :prop_names,
    #                     :as => :select,
    #                     :input_html => {:multiple => false},
    #                     :collection => PropName.includes(:strsubcats).where(:strsubcats => {:id => f.object.id})
    #
    #   end
    # end

    # f.inputs "Ценовые характеристики, которые выводятся на странице просмотра товара под картинкой (<a class='poiasn' href='#{image_url('samples/2015_11_22_item_price_props.jpg')}' target='_blank'>пример 1</a>, <a class='poiasn' href='#{image_url('samples/2015_11_22_item_price_props_list.jpg')}' target='_blank'>пример 2</a>)".html_safe, :class => 'collapsed-bug fieldset_price_props' do
    #   f.has_many :price_props, allow_destroy: true do |price_prop|
    #     price_prop.input :prop_names,
    #                     :as => :select,
    #                     :input_html => {:multiple => false},
    #                     :collection => PropName.includes(:strsubcats).where(:strsubcats => {:id => f.object.id}).where(:prop_names => {:is_normal_price => 1})
    #   end
    # end

    # f.inputs "Характеристки, которые выводятся на странице просмотра товара в блоке 'дополнительные характеристики' (<a class='poiasn' href='#{image_url('samples/2015_11_22_item_common_props.jpg')}' target='_blank'>например</a>)", :class => 'collapsed-bug fieldset_common_props' do
    #   f.has_many :common_props, allow_destroy: true do |common_prop|
    #     common_prop.input :prop_names,
    #                      :as => :select,
    #                      :input_html => {:multiple => false},
    #                      :collection => PropName.includes(:strsubcats).where(:strsubcats => {:id => f.object.id})
    #   end
    # end

    f.actions
  end

end