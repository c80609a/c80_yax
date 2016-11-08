module C80Yax

  # грузит картинку услуги
  class IphotoUploader < BaseFileUploader

    process :resize_to_limit => [1024,768]

    version :thumb_sm do
      Proc.new {
        p = C80Yax::Prop.first
        process :resize_to_fill => [p.thumb_sm_width, p.thumb_sm_height]
      }
    end

    version :thumb_md do
      Proc.new {
        p = C80Yax::Prop.first
        process :resize_to_fill => [p.thumb_md_width, p.thumb_md_height]
      }
    end

    version :thumb_lg do
      Proc.new {
        p = C80Yax::Prop.first
        process :resize_to_fill => [p.thumb_lg_width, p.thumb_lg_height]
      }
    end

    def store_dir
      'uploads/items'
    end

  end

end