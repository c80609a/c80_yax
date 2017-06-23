module C80Yax
  module UomHelper

    # на вход подаётся Uom
    # выдать оформленную html строку, которая содержит единицу измерения
    def pretty_uom_print(uom)
      return '' if uom.nil?
      str = uom.title
      pretty_uom_print_title(str)
    end

    # на вход подаётся строка
    # выдать оформленную html строку, которая содержит единицу измерения
    def pretty_uom_print_title(str)
      " (<span class='c80_md_link_color'>#{str}</span>)".html_safe
    end

  end
end