ActiveAdmin.register Pack::Suite, as: 'Suite' do

  menu :label => proc{ I18n.t('c80_yax.active_admin.menu.suite')},
       :parent => 'x_c80_yax',
       :priority => 9

  permit_params :title,
                :where,
                :url

  config.batch_actions = false
  config.sort_order = 'id_asc'
  before_filter :skip_sidebar!, :only => :index

  index do
    id_column
    column :title
    column :where
    column :url

    actions
  end

  form(:html => {:multipart => true}) do |f|

    f.inputs 'Свойства' do
      f.input :title
      f.input :where
      f.input :url
    end

    f.actions
  end

end