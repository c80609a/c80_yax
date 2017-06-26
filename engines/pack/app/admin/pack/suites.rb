ActiveAdmin.register Pack::Suite, as: 'Suite' do

  menu :label => proc{ I18n.t('c80_yax.active_admin.menu.suite')},
       :parent => 'x_c80_yax',
       :priority => 9

  permit_params :title,
                :where,
                :url,
                :srows_attributes => [:id, :_destroy, :item_id, :ord]

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

      f.inputs 'Товары' do
        f.has_many :srows, allow_destroy: true do |srow|
          srow.input :ord
          srow.input :item,
                     :as => :select,
                     :input_html => {
                         :title => '',
                         :class => 'selectpicker',
                         :data => {
                             :size => 10,
                             :width => '500px'
                         },
                         :multiple => false
                     },
                     :collection => C80Yax::Item.all.map { |o| ["#{o.title}", o.id]}
        end
      end

    end

    f.actions
  end

end