module C80Yax
  module Concerns
    module Props
      module Parsable

        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods

          # сервисный метод. Парсит результат sql запросов
          # в структуру, подходящую для view
          def parse_sql_props(rows, item_as_hash)

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