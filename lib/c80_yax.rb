require 'c80_yax/version'
require 'c80_yax/engine'
require 'c80_yax/strsubcat_runtime_tables'
require 'c80_yax/watermarker'
require 'c80_yax/item_photos_sizes_cache'
require 'rails-observers'
require 'mini_magick'
require_relative '../engines/pack/lib/pack'
require_relative '../engines/ti/lib/ti'
require_relative '../engines/of/lib/of'

module C80Yax
  def self.table_name_prefix
    'c80_yax_'
  end
end
