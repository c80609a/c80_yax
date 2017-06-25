require 'c80_yax/version'
require 'c80_yax/engine'
require 'c80_yax/strsubcat_runtime_tables'
require 'c80_yax/watermarker'
require 'rails-observers'
require 'mini_magick'
require_relative '../engines/pack/lib/pack'

module C80Yax
  def self.table_name_prefix
    'c80_yax_'
  end
end
