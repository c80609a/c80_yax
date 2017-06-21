module C80Yax
  class PriceProp < ActiveRecord::Base
    belongs_to :strsubcat
    has_and_belongs_to_many :prop_names

    # выдать таблицу, которая описывает список ценовых свойств, которые выводятся под картинкой
    # +---------------+--------------+---------------------+-----------+---------+
    # | price_prop_id | prop_name_id | title               | uom_title | related |
    # +---------------+--------------+---------------------+-----------+---------+
    # |             1 |           18 | Цена за шт.         | руб       |      19 |
    # |             2 |           20 | Цена за м²          | руб       |      21 |
    # +---------------+--------------+---------------------+-----------+---------+
    def self.gget_pprops_for_strsubcat(strsubcat_id)
      sql = "
    SELECT
      price_props_prop_names.*,
      prop_names.title,
      uoms.title as uom_title,
      prop_names.related
    FROM price_props
      LEFT JOIN price_props_prop_names ON price_props.id = price_props_prop_names.price_prop_id
      LEFT JOIN prop_names ON price_props_prop_names.prop_name_id = prop_names.id
      LEFT JOIN uoms ON prop_names.uom_id = uoms.id
    WHERE price_props.strsubcat_id = #{strsubcat_id};
    "
      rows = ActiveRecord::Base.connection.execute(sql)
      rows
    end

    # выдать id Имени Свойства типа "цена", по которому будет происходить "сортировка по цене"
    def self.gget_sort_pprop_for_strsubcat(strsubcat_id)
      rows = self.gget_pprops_for_strsubcat(strsubcat_id)
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