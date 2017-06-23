module C80Yax
  module Strsubcats

    # помогает оформлять списки свойств подкатегории

    # noinspection ALL
    module PropsHelper

      # include C80Yax::UomHelper

      # выдать название родительской категории в виде active_admin-ссылки
      def cat_admin_title(strsubcat)
        str = '-'
        if strsubcat.cats.count > 0
          c = strsubcat.cats.first
          t = c.title
          slug = c.slug
          str = "<a href='/admin/cats/#{slug}' title='#{t}'>#{t}</a>"
        end
        str.html_safe
      end

      # выдать html unordered list всех характеристик, которыми описывается подкатегория
      def all_props_list(strsubcat)
        res = '-'
        if strsubcat.prop_names.count > 0
          res = ''
          strsubcat.prop_names.each do |prop_name|
            res += "• #{title_with_uom(prop_name)}<br>"
          end
        end
        res.html_safe
      end

      # выдать html unordered list of 'main props'
      def main_props_list(strsubcat)
        res = ''
        C80Yax::MainProp.select_props_sql(strsubcat.id).each do |el|
          s = el[3]
          s += pretty_uom_print_title(el[4]) unless el[4].nil?
          res += "• #{s}<br>"
        end
        res.html_safe
      end

      # выдать html unordered list of 'price props'
      def price_props_list(strsubcat)
        res = ''
        C80Yax::PriceProp.gget_pprops_for_strsubcat(strsubcat.id).each do |el|
          s = el[2]
          s += pretty_uom_print_title(el[3]) unless el[3].nil?
          res += "• #{s}<br>"
        end
        res.html_safe
      end

      # выдать html unordered list of 'common props'
      def common_props_list(strsubcat)
        res = ''
        C80Yax::CommonProp.get_props_for_strsubcat(strsubcat.id).each do |el|
          s = el[3]
          s += pretty_uom_print_title(el[4]) unless el[4].nil?
          res += "• #{s}<br>"
        end
        res.html_safe
      end

      # выдать html unordered list of 'common props'
      def prefix_props_list(strsubcat)
        res = ''
        C80Yax::PrefixProp.get_props_for_strsubcat(strsubcat.id).each do |el|
          s = el[3]
          s += pretty_uom_print_title(el[4]) unless el[4].nil?
          res += "• #{s}<br>"
        end
        res.html_safe
      end

    end
  end
end