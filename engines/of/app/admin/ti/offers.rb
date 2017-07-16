ActiveAdmin.register Of::Offer, :as => 'Offer' do

  before_filter :skip_sidebar!, :only => :index

  menu :label => 'Акции',
       :parent => 'x_c80_yax',
       :priority => 10

  permit_params :title,
                :desc,
                :item_ids => [],
                :ophotos_attributes => [:id,:image,:_destroy]

  index do
    selectable_column
    id_column
    column :title
    column '' do |offer|
      if offer.ophotos.count > 0
        image_tag(offer.ophotos.first.image.thumb_sm)
      end
    end

    column :desc do |offer|
      res = '-'
      if offer.desc.present?
        res = "#{offer.desc[0..30]}..."
      end
      res
    end

    actions
  end

  form(:html => {:multipart => true}) do |f|
    f.inputs 'Свойства' do
      f.input :title

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

      f.inputs 'Фото' do
        f.has_many :ophotos, :allow_destroy => true do |ophoto|
          ophoto.input :image,
                       :as => :file,
                       :hint => image_tag(ophoto.object.image.thumb_sm)
        end
      end

      f.input :desc, :as => :ckeditor,
              :input_html => {:style => 'height:500px', rows: 20}

    end
    f.actions
  end

end