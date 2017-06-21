# ПОДкатегории строительных материалов
ActiveAdmin.register C80Yax::Cat, as: 'Cat' do

  menu :label => proc{ I18n.t('c80_yax.active_admin.menu.cat')},
       :parent => 'x_c80_yax',
       :priority => 1

  permit_params :title,
                :slug,
                :ord,
                :strsubcat_ids => []

  config.batch_actions = false
  config.sort_order = 'id_asc'
  before_filter :skip_sidebar!, :only => :index

  index do
    id_column
    column :ord
    column :title

    column :strsubcats do |cat|
      res = '-'
      if cat.strsubcats.count > 0
        res = ''
        cat.strsubcats.map do |strsubcat|
          res += "• #{strsubcat.title}<br>"
        end
      end
      res.html_safe
    end

    actions
  end

  form(:html => {:multipart => true}) do |f|

    f.inputs 'Свойства категории' do
      f.input :title
      f.input :ord
      f.input :strsubcats, :as => :check_boxes
    end

    f.actions
  end

end