module C80Yax
  module Cats
    module CatListsHelper

      def render_cats_iconed_list(n = 4)
        cats = Cat.iconed_list(n)
        render :partial => 'c80_yax/cats/cats_iconed_list',
               :locals => {
                   cats: cats
               }
      end

    end
  end
end