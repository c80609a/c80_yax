module C80Yax
  class PriceProp < ActiveRecord::Base
    belongs_to :strsubcat
    has_and_belongs_to_many :prop_names

    include C80Yax::Concerns::Props::Parsable

    # выдать таблицу, которая описывает список ценовых свойств, которые выводятся под картинкой
    # +---------------+--------------+---------------------+-----------+---------+
    # | price_prop_id | prop_name_id | title               | uom_title | related |
    # +---------------+--------------+---------------------+-----------+---------+
    # |             1 |           18 | Цена за шт.         | руб       |      19 |
    # |             2 |           20 | Цена за м²          | руб       |      21 |
    # +---------------+--------------+---------------------+-----------+---------+

    def self.select_props_sql(strsubcat_id)
      sql = "
    SELECT
      c80_yax_price_props_prop_names.*,
      c80_yax_prop_names.title,
      c80_yax_uoms.title as uom_title,
      c80_yax_prop_names.related_id
    FROM c80_yax_price_props
      LEFT JOIN c80_yax_price_props_prop_names ON c80_yax_price_props.id = c80_yax_price_props_prop_names.price_prop_id
      LEFT JOIN c80_yax_prop_names ON c80_yax_price_props_prop_names.prop_name_id = c80_yax_prop_names.id
      LEFT JOIN c80_yax_uoms ON c80_yax_prop_names.uom_id = c80_yax_uoms.id
    WHERE c80_yax_price_props.strsubcat_id = #{strsubcat_id};
    "
      rows = ActiveRecord::Base.connection.execute(sql)
      rows
    end

    # выдать id Имени Свойства типа "цена", по которому будет происходить "сортировка по цене"
    def self.gget_sort_pprop_for_strsubcat(strsubcat_id)
      rows = self.select_props_sql(strsubcat_id)
      if rows.count > 0
        rows.each(:as => :hash) do |row|
          return row["prop_name_id"]
        end
      else
        return ""
      end
    end

  end

end