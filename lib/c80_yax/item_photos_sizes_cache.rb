require 'singleton'
# require 'sizes_cache'

module C80Yax

  # Оптимизируем высокочастотные запросы к базе.

  class ItemPhotosSizesCache < ::SizesCache
    include Singleton

    def initialize
      super(C80Yax::Prop)
    end

  end

end