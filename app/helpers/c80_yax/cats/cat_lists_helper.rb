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

      def render_cats_strsubcats(&make_strsubcat_url)

        rdo = Cat.includes(:strsubcats)
        res = ''

        rdo.each do |category|
          r = "<h2 class='title'>#{category.title}</h2>"
          ds = ul_strsubcats(category, &make_strsubcat_url)
          next if ds.blank? # (**)
          r += ds
          res += "<li class='li_category' id='category_#{category.id}'>#{r}</li>"
        end

        "<ul class='ul_cats_strsubcats'>#{res}</ul>".html_safe

      end

      private

      def ul_strsubcats(category, &make_url)
        res = ''
        # noinspection RubyResolve
        category.strsubcats.each do |strsubcat|
          id = "strsubcat_#{strsubcat.id}"
          t = strsubcat.title
          u = make_url.call(strsubcat)
          d = "<a href='#{u}' title='#{t}'>#{t}</a>"
          res += "<li class='li_strsubcat' id='#{id}'>#{d}</li>"
        end
        return res if res.blank? # (*)
        "<ul class='ul_strsubcats'>#{res}</ul>"#.html_safe
      end

    end
  end
end