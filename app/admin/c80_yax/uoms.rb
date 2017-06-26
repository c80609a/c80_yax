# единицы измерения
ActiveAdmin.register C80Yax::Uom, as: 'Uom' do

  menu :label => proc{ I18n.t('c80_yax.active_admin.menu.uom')},
       :parent => 'x_c80_yax',
       :priority => 7

  permit_params :title, :comment, :is_number

  config.sort_order = 'title_desc'

  filter :title

  index do
    # selectable_column
    # id_column

    column :title
    column :comment
    column :is_number

    # actions
  end

  form(:html => {:multipart => true}) do |f|

    f.inputs "Свойства" do
      f.input :title
      f.input :comment
      f.input :is_number
    end
    f.actions
  end

end