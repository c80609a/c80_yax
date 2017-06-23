ActiveAdmin.register C80Yax::Vendor, as: 'Vendor' do

  menu :label => 'Производители',
       :parent => 'x_c80_yax',
       :priority => 0

  permit_params :title,
                :short,
                :content,
                :as_is

  # controller do
  #   cache_sweeper :vendor_sweeper, :only => [:update,:destroy]
  # end

  index do
    selectable_column
    # id_column

    column :title
    column :short

    actions
  end

  form(:html => {:multipart => true}) do |f|

    f.inputs 'Свойства' do

      f.input :title
      f.input :as_is
      f.input :short, :input_html => {:style => 'height:80px', :maxlength => 250}
      f.input :content, :as => :ckeditor

    end
    f.actions
  end

end