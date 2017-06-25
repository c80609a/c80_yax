module C80Yax

  # грузит картинку категории
  class IcatUploader < BaseFileUploader

    process :resize_to_limit => [1024,768]

    version :thumb_md do
      begin
        p = C80Yax::Prop.first
        process :resize_to_fill => [p.thumb_md_width, p.thumb_md_height]
      rescue => e
        Rails.logger.debug "[TRACE] <icat_uploader.thumb_md> [ERROR] #{e}"
      end
    end

    def store_dir
      'uploads/cats'
    end

  end

end