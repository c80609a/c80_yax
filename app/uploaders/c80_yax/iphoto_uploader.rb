module C80Yax

  # грузит картинку услуги
  class IphotoUploader < BaseFileUploader

    process :resize_to_limit => [1024,768]

    # накладываем watermark
    process :watermark => [Rails.root.join('public/watermark.png')]

    version :thumb_sm do
      begin
        p = C80Yax::Prop.first
        process :resize_to_fill => [p.thumb_sm_width, p.thumb_sm_height]
      rescue => e
        Rails.logger.debug "[TRACE] <iphoto_uploader.thumb_sm> [ERROR] #{e}"
      end
    end

    version :thumb_md do
      begin
        p = C80Yax::Prop.first
        process :resize_to_fill => [p.thumb_md_width, p.thumb_md_height]
      rescue => e
        Rails.logger.debug "[TRACE] <iphoto_uploader.thumb_md> [ERROR] #{e}"
      end
    end

    version :thumb_lg do
      begin
        p = C80Yax::Prop.first
        process :resize_to_fill => [p.thumb_lg_width, p.thumb_lg_height]
      rescue => e
        Rails.logger.debug "[TRACE] <iphoto_uploader.thumb_lg> [ERROR] #{e}"
      end
    end

    def watermark(watermark_image, options={})
      cache_stored_file! unless cached?
      C80Yax::Watermarker.new(current_path, watermark_image).watermark!(options)
    end

    def store_dir
      'uploads/items'
    end

  end

end