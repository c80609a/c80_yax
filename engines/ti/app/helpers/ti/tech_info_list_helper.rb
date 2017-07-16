module Ti
  module TechInfoListHelper

    # Выдать html unordered nested list Дилеров (включая Офисы),
    # разложенный по Регионам, построенный
    # на основе данных +rdo+ - Regions-Dealers-Offices.
    # Список выводится слева от карты.
    # (**) Не выводим регионы, у которых нет дилеров.
    #
    # Структура списка:
    # * Регион
    #     * Дилер
    #         * Офис 1
    #             * адрес офиса
    #             * телефон офиса
    #         * Офис 2
    #             * адрес офиса
    #             * телефон офиса
    #         * сайт дилера
    #         * email дилера
    #
    def __render_ul_dealers_list(rdo)

      res = ''

      rdo.each do |region|
        r = "<h2 class='region_title'>#{region.title}</h2>"
        ds = ul_region_dealers(region)
        next if ds.blank? # (**)
        r += ds
        res += "<li class='li_region' id='region_#{region.id}'>#{r}</li>"
      end

      "<ul class='ul_dealers_list'>#{res}</ul>".html_safe

    end

    private

    # используется только в render_dealers_list
    # (*) не выводим список дилеров, если он пуст
    def ul_region_dealers(region)
      res = ''
      # noinspection RubyResolve
      region.dealers.each do |dealer|
        d = "<h3 class='dealer_title'>#{dealer.title}</h3>"
        d += ul_dealer_offices(dealer)
        res += "<li class='li_dealer' id='dealer_#{dealer.id}'>#{d}</li>"
      end
      return res if res.blank? # (*)
      "<ul class='ul_region_dealers'>#{res}</ul>" #.html_safe
    end

    # используется только в ul_region_dealers
    def ul_dealer_offices(dealer)
      res = ''
      # noinspection RubyResolve
      dealer.offices.each_with_index do |office|
        o = "<h4 class='office_title'>#{office.title}</h4>"
        o += ul_office_props(office)
        res += "<li class='li_office' id='office_#{office.id}' data-id='#{office.id}'>#{o}</li>"
      end
      res += "<li class='dealer_email'>#{dealer.email}</li>"
      res += "<li class='dealer_site'>#{dealer.site}</li>"
      "<ul class='ul_dealer_offices'>#{res}</ul>" #.html_safe
    end

    # используется только в ul_dealer_offices
    def ul_office_props(office)
      res = ''
      res += "<li class='office_addr'>#{office.addr}</li>"
      res += "<li class='office_tel'>#{office.tel}</li>"
      "<ul class='ul_office_props'>#{res}</ul>" #.html_safe
    end

  end
end