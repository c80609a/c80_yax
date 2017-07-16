module Of
  class OphotoUploader < BaseFileUploader

    # ограничение оригинальной картинки
    process :resize_to_limit => [1600,1600]

    def store_dir
      "uploads/offers/#{format('%02d', model.offer_id)}"
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

    # ------------------------------------------------------------------------------------------------------------------------

    def resize_to_lg
      # byebug

      w = 1250
      h = 260

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

        w = 600
        h = 130

        img.resize "#{w}x#{h}^"
        img.gravity 'center'
        img.extent "#{w}x#{h}"
        img = yield(img) if block_given?
        img

      end

    end

    def resize_to_sm

      manipulate! do |img|

        w = 300
        h = 60

        img.resize "#{w}x#{h}^"
        img.gravity 'center'
        img.extent "#{w}x#{h}"
        img = yield(img) if block_given?
        img

      end

    end

  end
end