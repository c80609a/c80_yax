require 'rails/generators/base'
require 'rails/generators/resource_helpers'

module C80Yax
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def create_root_folder
        empty_directory 'app/helpers/c80_yax'
      end

      def copy_template_file
        template 'app/helpers/c80_yax/items/show_item_helper.rb',
                 File.join('app/helpers/c80_yax/items', 'show_item_helper.rb')
      end

    end
  end
end