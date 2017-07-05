module C80Yax
  module Cats
    module CatListsHelper

      def render_cats_iconed_list(n = 4, &make_url)
        proc_make_url = proc &make_url
        cats = Cat.iconed_list(n)
        render :partial => 'c80_yax/cats/cats_iconed_list',
               :locals => {
                   cats: cats,
                   proc_make_url: proc_make_url
               }
      end

    end
  end
end