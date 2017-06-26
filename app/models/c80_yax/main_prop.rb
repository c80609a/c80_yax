module C80Yax
  class MainProp < ActiveRecord::Base
    belongs_to :strsubcat
    has_and_belongs_to_many :prop_names
    public_constant :HABTM_PropNames

    include C80Yax::Concerns::Props::Parsable

    # выдать таблицу, которая описывает список свойств, которые выводятся справа от картинки
    # +--------------+--------------+--------------+---------------------------+-----------+
    # | strsubcat_id | main_prop_id | prop_name_id | title                     | uom_title |
    # +--------------+--------------+--------------+---------------------------+-----------+
    # |            1 |            1 |           23 | Размер                    | NULL      |
    # |            1 |            2 |           27 | Марка по морозостойкости  | NULL      |
    # |            1 |            3 |           33 | Вес                       | кг        |
    # |            1 |            4 |           28 | Водопоглощение            | %         |
    # +--------------+--------------+--------------+---------------------------+-----------+

    def self.select_props_sql(strsubcat_id)
      Rails.logger.debug "[TRACE] <MainProp.select_props_sql> strsubcat_id = #{strsubcat_id}"
      sql = "
      SELECT
        c80_yax_main_props.strsubcat_id,
        c80_yax_main_props_prop_names.*,
        c80_yax_prop_names.title,
        c80_yax_uoms.title as uom_title
      FROM c80_yax_main_props
        LEFT JOIN c80_yax_main_props_prop_names ON c80_yax_main_props.id = c80_yax_main_props_prop_names.main_prop_id
        LEFT JOIN c80_yax_prop_names ON c80_yax_main_props_prop_names.prop_name_id = c80_yax_prop_names.id
        LEFT JOIN c80_yax_uoms ON c80_yax_prop_names.uom_id = c80_yax_uoms.id
      WHERE c80_yax_main_props.strsubcat_id = #{strsubcat_id};
    "
      rows = ActiveRecord::Base.connection.execute(sql)
      rows
    end

  end

end