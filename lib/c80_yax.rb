require 'c80_yax/version'
require 'c80_yax/engine'
require 'c80_yax/strsubcat_runtime_tables'
require 'rails-observers'

module C80Yax
  def self.table_name_prefix
    'c80_yax_'
  end
end
