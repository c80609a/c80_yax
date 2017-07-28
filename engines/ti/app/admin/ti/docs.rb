ActiveAdmin.register Ti::Doc, :as => 'Doc' do

  before_filter :skip_sidebar!, :only => :index

  menu :label => 'Документы',
       :parent => 'x_ti',
       :priority => 1

  permit_params :title,
                :full,
                :category_ids => [],
                :item_ids => [],
                :dphotos_attributes => [:id,:image,:_destroy]

  index do
    selectable_column
    id_column
    column :title
    column :created_at do |fact|
      local_time(fact[:created_at], format: '%e.%m.%Y')
    end

    column '' do |fact|
      if fact.dphotos.count > 0
        image_tag(fact.dphotos.first.image.thumb_sm)
      end
    end

    column :full do |doc|
      res = '-'
      if doc.full.present?
        res = "#{doc.full[0..30]}..."
      end
      res
    end

    actions
  end

  form(:html => {:multipart => true}) do |f|
    f.inputs 'Свойства' do
      f.input :title

      f.input :categories,
              :as => :select,
              :input_html => {
                  :title => '',
                  :class => 'selectpicker',
                  :data => {
                      :size => 10
                  },
                  :multiple => false
              },
              :include_blank => true

      f.inputs 'Фото' do
        f.has_many :dphotos, :allow_destroy => true do |dphoto|
          dphoto.input :image,
                       :as => :file,
                       :hint => image_tag(dphoto.object.image.thumb_sm)
        end
      end

      f.input :items,
              :as => :select,
              :input_html => {
                  :title => '',
                  :class => 'selectpicker',
                  :data => {
                      :size => 10,
                      :width => '700px'
                  },
                  :multiple => true
              },
              :include_blank => true

      f.input :full, :as => :ckeditor,
              :input_html => {:style => 'height:500px', rows: 20}

    end
    f.actions
  end

end