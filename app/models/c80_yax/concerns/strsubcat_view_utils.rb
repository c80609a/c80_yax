module C80Yax
  module Concerns
    module StrsubcatViewUtils
      extend ActiveSupport::Concern
      include C80Yax::UomHelper

      # выдать название родительской категории в виде active_admin-ссылки
      def cat_admin_title
        str = '-'
        if self.cats.count > 0
          c = self.cats.first
          t = c.title
          slug = c.slug
          str = "<a href='/admin/cats/#{slug}' title='#{t}'>#{t}</a>"
        end
        str.html_safe
      end

      # выдать html unordered list всех характеристик, которыми описывается подкатегория
      def all_props_list
        res = '-'
        if self.prop_names.count > 0
          res = ''
          self.prop_names.each do |prop_name|
            res += "• #{prop_name.title_with_uom}<br>"
          end
        end
        res.html_safe
      end

      # выдать html unordered list of 'main props'
      def main_props_list
        res = ''
        C80Yax::MainProp.get_props_for_strsubcat(self.id).each do |el|
          s = el[3]
          s += pretty_uom_print_title(el[4]) unless el[4].nil?
          res += "• #{s}<br>"
        end
        res.html_safe
      end

      # выдать html unordered list of 'price props'
      def price_props_list
        res = ''
        C80Yax::PriceProp.gget_pprops_for_strsubcat(self.id).each do |el|
          s = el[2]
          s += pretty_uom_print_title(el[3]) unless el[3].nil?
          res += "• #{s}<br>"
        end
        res.html_safe
      end

      # выдать html unordered list of 'common props'
      def common_props_list
        res = ''
        C80Yax::CommonProp.get_props_for_strsubcat(self.id).each do |el|
          s = el[3]
          s += pretty_uom_print_title(el[4]) unless el[4].nil?
          res += "• #{s}<br>"
        end
        res.html_safe
      end

      # выдать collection of `main props`, связанных с этой подкатегорией
      def main_props_collection
        C80Yax::PropName
            .includes(:strsubcats)
            .where(:c80_yax_strsubcats => {:id => self.id})
      end

      # выдать collection of `price props` associated with this Strsubcat
      def price_props_collection
        C80Yax::PropName
            .includes(:strsubcats)
            .where(:c80_yax_strsubcats => {:id => self.id})
            .where(:c80_yax_prop_names => {:is_normal_price => 1})
      end

      # выдать collection of `common props` associated with this Strsubcat
      def common_props_collection
        C80Yax::PropName
            .includes(:strsubcats)
            .where(:c80_yax_strsubcats => {:id => self.id})
      end

    end
  end
end