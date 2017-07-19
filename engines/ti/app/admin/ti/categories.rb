ActiveAdmin.register Ti::Category, as: 'Category' do

  menu :label => 'Категории',
       :parent => 'x_ti',
       :priority => 2

  permit_params :title,
                :full,
                :ord,
                :is_listed,
                :parent_category_id

  config.sort_order = 'id_asc'
  # config.clear_action_items!
  config.batch_actions = false

  scope  "All", :all
  scope  "Listed", :listed

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
    column :ord
    column :is_listed
    column :parent_category do |pn|
      if pn.parent_category_id.present?
        rpn = Ti::Category.find_by(id:pn.parent_category_id)
        rpn.title unless rpn.nil?
      end
    end

    actions
  end

  form(:html => {:multipart => true}) do |f|

    f.inputs 'Свойства' do
      f.input :title
      f.input :ord
      f.input :is_listed

      f.input :parent_category,
              as: :select,
              collection: Ti::Category.all,
              input_html: {
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

    f.actions

  end

end