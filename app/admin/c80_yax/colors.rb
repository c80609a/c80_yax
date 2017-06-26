ActiveAdmin.register C80Yax::Color, as: 'Color' do

  menu :label => proc{ I18n.t('c80_yax.active_admin.menu.color')},
       :parent => 'x_c80_yax',
       :priority => 8

  permit_params :title,
                :value,
                :skidka,
                :item_ids => []

  config.batch_actions = false
  config.sort_order = 'id_asc'
  before_filter :skip_sidebar!, :only => :index

  index do
    id_column
    column :title
    column :value
    column :skidka
    column :items

    actions
  end

  form(:html => {:multipart => true}) do |f|

    f.inputs 'Свойства' do
      f.input :title
      f.input :value, :as => :color
      f.input :skidka
      f.input :items, :as => :check_boxes
    end

    f.actions
  end

end