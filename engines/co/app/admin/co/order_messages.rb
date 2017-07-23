ActiveAdmin.register Co::OrderMessage, :as => 'OrderMessage' do

  before_filter :skip_sidebar!, :only => :index

  menu :label => 'Заказы',
       :parent => 'x_c80_yax',
       :priority => 20

  index do
    selectable_column
    id_column
    column :created_at
    column :name
    column :phone
    column :comment do |msg|
      msg.comment.html_safe if msg.comment.present?
    end

    actions
  end


end