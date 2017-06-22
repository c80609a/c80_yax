# ПОДкатегории строительных материалов
ActiveAdmin.register C80Yax::Strsubcat, as: 'Strsubcat' do

  menu :label => proc{ I18n.t('c80_yax.active_admin.menu.strsubcat')},
       :parent => 'x_c80_yax',
       :priority => 2

  permit_params :title,
                :slug,
                :ord,
                :parent_id,
                :cat_ids => [],
                :prop_name_ids => [],
                :main_props_attributes => [:id, :_destroy, :prop_name_ids => []],
                :common_props_attributes => [:id, :_destroy, :prop_name_ids => []],
                :price_props_attributes => [:id, :_destroy, :prop_name_ids => []],
                :prefix_props_attributes => [:id, :_destroy, :prop_name_ids => []]

  config.sort_order = 'id_asc'

  # controller do
  #   cache_sweeper :strsubcat_sweeper, :only => [:update,:create,:destroy]
  # end

  # before_filter :skip_sidebar!, :only => :index

  filter :title
  # filter :parent_id_in,
  #        :as => :select,
  #        :collection => -> { C80Yax::Strsubcat.all.map { |s| [s.title,s.id] }},
  #        :input_html => {
  #            :class => 'selectpicker',
  #            :title => '',
  #            :data => {
  #                :size => 10,
  #                :width => '100%'
  #            }
  #        }

  # controller do
  #   cache_sweeper :suit_sweeper, :only => [:update,:create,:destroy]
  # end

  index do
    selectable_column
    id_column
    column :ord
    column :title
    # column :parent

    column :cats do |str_sub_cat|
      cat_admin_title(str_sub_cat)
    end

    column :prop_names do |strsubcat|
      all_props_list(strsubcat)
    end

    actions
  end

  form(:html => {:multipart => true}) do |f|

    f.inputs 'Свойства подкатегории' do
      f.input :title
      f.input :ord
      f.input :cats,
              :as => :select,
              :input_html => {
                  :class => 'selectpicker',
                  :title => ' ',
                  :data => {
                      :size => '10',
                      :width => '400px'
                  },
                  :multiple => false
              },
              :include_blank => true

      # f.input :parent,
      #         :as => :select,
      #         :collection => C80Yax::Strsubcat.where.not(id:f.object.id).map { |s| ["#{s.title}", s.id]},
      #         :input_html => {
      #             :class => 'selectpicker',
      #             :title => ' ',
      #             :data => {
      #                 :size => '10',
      #                 :width => '400px'
      #             },
      #             :multiple => false
      #         },
      #         :include_blank => true
      #

    end

    f.inputs I18n.t('c80_yax.active_admin.pages.strsubcat.label_all_props'), :class => 'collapsed' do
      f.input :prop_names, :as => :check_boxes
    end

    f.inputs I18n.t('c80_yax.active_admin.pages.strsubcat.label_main_props',
                    img: image_url('samples/2017_06_20_item_main_props.jpg')).html_safe,
             :class => 'collapsed fieldset_main_props' do
      f.has_many :main_props, allow_destroy: true do |main_prop|
        main_prop.input :prop_names,
                        :as => :select,
                        :input_html => {
                            :class => 'selectpicker',
                            :title => ' ',
                            :data => {
                                :size => '10',
                                :width => '400px'
                            },
                            :multiple => false
                        },
                        :collection => f.object.main_props_collection

      end
    end

    f.inputs I18n.t('c80_yax.active_admin.pages.strsubcat.label_price_props',
                    img: image_url('samples/2017_06_20_item_price_props.jpg')).html_safe,
             :class => 'collapsed fieldset_price_props' do
      f.has_many :price_props, allow_destroy: true do |price_prop|
        price_prop.input :prop_names,
                        :as => :select,
                         :input_html => {
                             :class => 'selectpicker',
                             :title => ' ',
                             :data => {
                                 :size => '10',
                                 :width => '400px'
                             },
                             :multiple => false
                         },
                        :collection => f.object.price_props_collection
      end
    end

    f.inputs I18n.t('c80_yax.active_admin.pages.strsubcat.label_common_props',
                    img: image_url('samples/2017_06_20_item_common_props.jpg')).html_safe,
             :class => 'collapsed fieldset_common_props' do
      f.has_many :common_props, allow_destroy: true do |common_prop|
        common_prop.input :prop_names,
                         :as => :select,
                          :input_html => {
                              :class => 'selectpicker',
                              :title => ' ',
                              :data => {
                                  :size => '10',
                                  :width => '400px'
                              },
                              :multiple => false
                          },
                         :collection => f.object.common_props_collection
      end
    end

    f.inputs I18n.t('c80_yax.active_admin.pages.strsubcat.label_prefix_props',
                    img: image_url('samples/2017-06-21_item_prefix_props.jpg')),
             :class => 'collapsed fieldset_common_props' do
      f.has_many :prefix_props, allow_destroy: true do |prefix_prop|
        prefix_prop.input :prop_names,
                          :as => :select,
                          :input_html => {
                              :class => 'selectpicker',
                              :title => ' ',
                              :data => {
                                  :size => '10',
                                  :width => '400px'
                              },
                              :multiple => false
                          },
                          :collection => f.object.prefix_props_collection
      end
    end

    f.actions
  end

  show do
    render 'view', { s: strsubcat }
  end

end