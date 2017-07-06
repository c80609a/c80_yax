module Ti
  class Dphoto < ActiveRecord::Base
    belongs_to :doc
    mount_uploader :image, DphotoUploader

    # в ~ от размеров thumb-ов и page_content_width - выдать соответствующую картинку
    # • Если у картинки thumb_big шириной ≥ page_content_width - вставляем этот thumb_big.
    # • Иначе: вставлем thumb_small.
    def content_image(type='normal')

      if type == 'normal'
        img = MiniMagick::Image.open(image.thumb_big.path)
        w = SiteProp.first.page_content_width
        if img['width'] < w
          image.thumb_small
        else
          image.thumb_big
        end

      elsif type == 'small'
        image.thumb_small

      elsif type == 'big'
        image.thumb_big
      end

    end

    # выдать размеры картинки, которая будет вставлена в текст страницы
    def content_image_size(type='normal')

      if type == 'normal'
        img = MiniMagick::Image.open(image.thumb_big.path)
        w = SiteProp.first.page_content_width
        if img['width'] < w
          img = MiniMagick::Image.open(image.thumb_small.path)
          [img['width'], img['height']]
        else
          [img['width'], img['height']]
        end

      elsif type == 'small'
        img = MiniMagick::Image.open(image.thumb_small.path)
        [img['width'], img['height']]

      elsif type == 'big'
        img = MiniMagick::Image.open(image.thumb_big.path)
        [img['width'], img['height']]
      end
    end

    # выдать размеры картинки thumb_preview
    def thumb_preview_size
      img = MiniMagick::Image.open(image.thumb_preview.path)
      [img['width'], img['height']]
    end

  end
end