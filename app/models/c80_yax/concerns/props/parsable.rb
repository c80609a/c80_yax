module C80Yax
  module Concerns
    module Props
      module Parsable

        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods

          # Выдать стуктуру, годную для обработки для view,
          # в которой содержатся данные характеристиках предмета.
          # +strsubcat_id+ подкатегория, которой принадлежит Товар
          # +item_as_hash+ это результат запроса к runtime таблице

          def get_props_parsed(strsubcat_id, item_as_hash)
            rows = self.select_props_sql(strsubcat_id)
            meth =  (self.name == 'C80Yax::PriceProp') ? '__parse_sql_price_props' : '__parse_sql_props'
            self.send(meth, rows, item_as_hash)
          end

          # переопределится в классе
          # noinspection RubyUnusedLocalVariable
          def select_props_sql(strsubcat_id)

          end

          protected

          # сервисный метод. Парсит результат sql запросов
          # в структуру, подходящую для view
          # +rows+ это результат select запроса `select_props_sql`
          # +item_as_hash+ это результат select запроса к runtime таблице

          def __parse_sql_props(rows, item_as_hash)

            result = {
                titles: [],
                values: [],
                uoms:   []
            }

            rows.each(:as => :hash) do |row|

              result[:titles] << row['title']
              result[:values] << item_as_hash['prop_'+row['prop_name_id'].to_s]
              result[:uoms] << row['uom_title']

            end

            result
          end

          # сервисный метод. Подходит для ценовых характеристик,
          # т.к. есть такое понятие, как "старая цена"
          # +rows+ это результат select запроса `C80Yax::PriceProp.select_props_sql`
          # +item_as_hash+ это результат select запроса к runtime таблице
          #
          # Вернёт результат вида:
          # {
          #   :titles=>["Цена", "Цена за дюжину"],
          #   :values=>["1200,00", "11223,00"],
          #   :values_old=>["30000,00", "555,00"],
          #   :uoms=>["руб", "руб"]
          # }

          def __parse_sql_price_props(rows, item_as_hash)

            result = {
                titles:     [],
                values:     [],
                values_old: [],
                uoms:       []
            }

            rows.each(:as => :hash) do |row|

              if item_as_hash['prop_'+row['prop_name_id'].to_s].to_i != 0

                title = row['title']
                value = item_as_hash['prop_'+row['prop_name_id'].to_s]
                uom = row['uom_title']
                related = row['related_id']

                # нормальная цена
                value = format('%.2f', value).gsub('.', ',')

                # result += '<li>'
                # result += "<p class='ptitle medium'>#{title}</p>" # Цена за шт | Цена за м²
                # result += "<p><span class='pvalue bold'>#{format("%.2f", value).gsub('.', ',')}<span> <span class='puom'>#{uom}</span></p>" # 1212,80 руб

                # старая цена
                # byebug

                # Rails.logger.debug "[TRACE] item_as_hash['is_sale'] = #{item_as_hash['is_sale']}"
                # if [true, 1, '1'].include? item_as_hash['is_sale']
                  if related.present?
                    related_value = item_as_hash['prop_'+related.to_s]
                    if related_value.present?
                      v = related_value.gsub(',', '.') # это число используем только для сравнения с 0
                      if v.to_f > 0
                        value_old = format('%.2f', v.to_f).gsub('.', ',')
                        # result += "<p class='old'><span class='pvalue bold'>#{format("%.2f", v.to_f).gsub('.', ',')}</span> <span class='puom'>#{uom}</span></p>" # 1212,80 руб
                      end
                    end
                  end
                # end

                result[:titles] << title
                result[:values] << value
                result[:values_old] << value_old
                result[:uoms] << uom

                # result += '</li>'
              end

            end

            result

          end

        end

      end
    end
  end
end