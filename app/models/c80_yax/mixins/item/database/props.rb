module C80Yax
  module Mixins
    module Item
      module Database

        # Методами `prefix_props`, `item_as_hash`, `get_item_as_hash` пользуемся тогда,
        # когда контроллер извлекает данные о предмете из таблицы `c80_yax_items`
        # в номинальном режиме вида `@item = C80Yax::Item.find(id)`.

        module Props

          # сформировать список prefix свойств предмета
          def prefix_props
            C80Yax::PrefixProp.get_props_parsed(self.strsubcat_id, item_as_hash)
          end

          # сформировать список main свойств предмета
          def main_props
            Rails.logger.debug '[TRACE] <Item::Database.main_props>'
            C80Yax::MainProp.get_props_parsed(self.strsubcat_id, item_as_hash)
          end

          # сформировать список common свойств предмета
          def common_props
            C80Yax::CommonProp.get_props_parsed(self.strsubcat_id, item_as_hash)
          end

          # сформировать список ценовых свойств предмета
          def price_props
            C80Yax::PriceProp.get_props_parsed(self.strsubcat_id, item_as_hash)
          end

          # здесь хранятся данные о предмете из runtime таблицы
          def item_as_hash
            @item_as_hash ||= get_item_as_hash
          end

          private

          # получить данные о товаре из runtime таблицы
          def get_item_as_hash

            # item_as_hash = {"id"=>84, "item_id"=>1, "item_title"=>"Кирпич облицовочный Labassa стандарт качества Qbricks",
            # "is_main"=>0, "is_hit"=>0, "is_sale"=>1, "strsubcat_slug"=>"kirpich", "prop_18"=>"13,85", "prop_19"=>"15",
            # "prop_20"=>"16", "prop_21"=>"18", "prop_23"=>"250 x 85 x 65 мм", "prop_24"=>"Румыния", "prop_25"=>"150",
            # "prop_26"=>"0,60", "prop_27"=>"F300", "prop_28"=>"12,8", "prop_29"=>"красный", "prop_30"=>"пустотелый",
            # "prop_31"=>"пластичное формование", "prop_32"=>"гладкая", "prop_33"=>"1,5", "prop_34"=>"458",
            # "prop_35"=>"лицевой, фасадный", "prop_36"=>"Ibstock", "prop_37"=>"GE-02 A", "prop_38"=>"BS"}

            # noinspection RubyResolve
            strsubcat_id = self.strsubcat.id
            item_id = self.id

            sql = "SELECT * FROM `c80_yax_strcat_#{strsubcat_id}_items` WHERE `item_id` = #{item_id}"
            rows = ActiveRecord::Base.connection.execute(sql)
            # т.к. результат может быть только в виде одного объекта - вернём первую попавшуюся строку
            rows.each(:as => :hash) do |row|
              # Rails.logger.debug "#{row['item_title']}"
              return row
            end
          end

        end
      end
    end
  end
end
