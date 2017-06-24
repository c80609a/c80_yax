module C80Yax
  class Watermarker

    def initialize(original_path, watermark_path)
      @original_path = original_path.to_s
      @watermark_path = watermark_path.to_s
    end

    def watermark!(options={})
      options[:gravity] ||= 'center'

      image = MiniMagick::Image.open(@original_path)
      watermark_image = MiniMagick::Image.open(@watermark_path)

      result = image.composite(watermark_image) do |c|
        c.gravity options[:gravity]
      end

      result.write @original_path

    end

  end
end