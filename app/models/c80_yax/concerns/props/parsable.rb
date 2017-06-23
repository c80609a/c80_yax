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
            self.__parse_sql_props(rows, item_as_hash)
          end

          # переопределится в классе
          # noinspection RubyUnusedLocalVariable
          def select_props_sql(strsubcat_id)

          end

          protected

          # сервисный метод. Парсит результат sql запросов
          # в структуру, подходящую для view
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

        end

      end
    end
  end
end