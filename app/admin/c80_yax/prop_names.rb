# категории строительных материалов
ActiveAdmin.register C80Yax::PropName, as: 'PropName' do

  menu :label => proc{ I18n.t('c80_yax.active_admin.menu.prop_name')},
       :parent => 'x_c80_yax',
       :priority => 6

  permit_params :title,
                :uom_id,
                :is_excluded_from_filtering,
                :is_normal_price,
                :related_id

  config.sort_order = 'id_asc'
  # config.clear_action_items!
  config.batch_actions = false

  # filter :title
  # filter :strsubcats
  # filter :is_excluded_from_filtering
  # filter :is_normal_price

  before_filter :skip_sidebar!, :only => :index

  # controller do
  #   cache_sweeper :suit_sweeper, :only => [:update,:create,:destroy]
  # end

  index do
    # selectable_column
    id_column

    column :title
    column :uom
    column :is_excluded_from_filtering
    column :is_normal_price
    column :related do |pn|
      if pn.related_id.present?
        rpn = C80Yax::PropName.find(pn.related_id)
        rpn.title
      end
    end

    actions
  end

  form(:html => {:multipart => true}) do |f|

    f.inputs "Свойства" do
      f.input :title,
              :hint => 'Например: цвет, размер, ширина'
      f.input :uom,
              :as => :select,
              :input_html => {
                  :class => 'selectpicker',
                  :title => '',
                  :data => {
                      :size => 10,
                      :width => '400px'
                  },
                  :multiple => false
              },
              :include_blank => true

      f.input :related,
              as: :select,
              collection: C80Yax::PropName.all,
              :hint => 'Только для цен. Если есть подобная "старая" цена, то необходимо указать'.html_safe,
              :input_html => {
                  :class => 'selectpicker',
                  :title => '',
                  :data => {
                      :size => 10,
                      :width => '400px'
                  },
                  :multiple => false
              },
              :include_blank => true

    end

    f.inputs 'Дополнительные характеристики' do
      f.input :is_excluded_from_filtering,
              :hint => "Свойство не будет фигурировать в списке фильтрации (<a class='poiasn' href='#{image_url('samples/20151022_prop_name_is_excluded_from_filtering.jpg')}' target='_blank'>например</a>)".html_safe

      f.input :is_normal_price,
              :hint => "Является ли свойство 'нормальной' (нестарой) ценой?".html_safe
    end

    f.actions

  end

end