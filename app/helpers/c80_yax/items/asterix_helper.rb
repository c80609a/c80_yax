module C80Yax
  module Items
    module AsterixHelper

      def render_asterix
        # TODO-5:: перенести этот текст в базу, в свойства модуля
        a = '*точная стоимость будет озвучена нашим менеджером при телефонном разговоре с клиентом'
        "<p>#{a}</p>".html_safe
      end

    end
  end
end