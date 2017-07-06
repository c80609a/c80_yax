module Ti
  class DphotoUploader < BaseFileUploader

    # ограничение оригинальной картинки
    process :resize_to_limit => [1600,1600]

    def store_dir
      "uploads/docs/#{format('%02d', model.fact_id)}"
    end

    # ---[ идут в контент новости ]---[ размер зависит от SiteProps.page_content_width ]--------------------------------------------------------------------------------------------------------------------

    version :thumb_big do
      process :resize_to_thumb_big
    end

    version :thumb_small do
      process :resize_to_thumb_small
    end

    # ------------------------------------------------------------------------------------------------------------------------

    version :thumb_preview do
      begin
        # Proc.new {
        p = C80News::Prop.first
        process :resize_to_fill => [p.thumb_preview_width, p.thumb_preview_height]
        # }
      rescue => e
        Rails.logger.debug "[TRACE] <C80News.fphoto_uploader> thumb_preview ERROR: #{e}"
      end
    end

    version :thumb_lg do
      process :resize_to_lg
    end

    version :thumb_md do
      process :resize_to_md
    end

    version :thumb_sm do
      process :resize_to_sm
    end

    # --[ идут в контент новости ]--------------------------------------------------------------------------------------

    def resize_to_thumb_big
      # byebug

      w = SiteProp.first.page_content_width
      h = calc_height_of_image(w)

      # puts "<PageArtUploader.resize_to_limit_big>"
      manipulate! do |img|
        img.resize "#{w}x#{h}>"
        img = yield(img) if block_given?
        img
      end

    end

    def resize_to_thumb_small
      # puts "<PageArtUploader.resize_to_limit_small>"
      manipulate! do |img|

        w = SiteProp.first.page_content_width/2
        h = calc_height_of_image(w)

        img.resize "#{w}x#{h}>"
        img = yield(img) if block_given?
        img

      end
    end

    # ------------------------------------------------------------------------------------------------------------------------

    def resize_to_lg
      # byebug

      w = C80News::Prop.first.thumb_lg_width
      h = C80News::Prop.first.thumb_lg_height

      manipulate! do |img|
        img.resize "#{w}x#{h}^"
        img.gravity 'center'
        img.extent "#{w}x#{h}"
        img = yield(img) if block_given?
        img
      end

    end

    def resize_to_md

      manipulate! do |img|

        w = C80News::Prop.first.thumb_md_width
        h = C80News::Prop.first.thumb_md_height

        img.resize "#{w}x#{h}^"
        img.gravity 'center'
        img.extent "#{w}x#{h}"
        img = yield(img) if block_given?
        img

      end

    end

    def resize_to_sm

      manipulate! do |img|

        w = C80News::Prop.first.thumb_sm_width
        h = C80News::Prop.first.thumb_sm_height

        img.resize "#{w}x#{h}^"
        img.gravity 'center'
        img.extent "#{w}x#{h}"
        img = yield(img) if block_given?
        img

      end

    end

    # ------------------------------------------------------------------------------------------------------------------------

    protected
    def secure_token(length=16)
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
    end
    
    private

    def calc_height_of_image(w)
      model_image = ::MiniMagick::Image.open(current_path)
      calc_height(w, model_image["width"], model_image["height"])
    end

    # подгоняем по ширине, рассчитываем высоту
    def calc_height(width, original_w, original_h)
      k = width.to_f/original_w
      original_h * k
    end


  end
end