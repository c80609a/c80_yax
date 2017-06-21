module C80Yax
  class MainProp < ActiveRecord::Base
    belongs_to :strsubcat
    has_and_belongs_to_many :prop_names

    # выдать таблицу, которая описывает список свойств, которые выводятся справа от картинки
    # +--------------+--------------+--------------+---------------------------+-----------+
    # | strsubcat_id | main_prop_id | prop_name_id | title                     | uom_title |
    # +--------------+--------------+--------------+---------------------------+-----------+
    # |            1 |            1 |           23 | Размер                    | NULL      |
    # |            1 |            2 |           27 | Марка по морозостойкости  | NULL      |
    # |            1 |            3 |           33 | Вес                       | кг        |
    # |            1 |            4 |           28 | Водопоглощение            | %         |
    # +--------------+--------------+--------------+---------------------------+-----------+
    def self.get_props_for_strsubcat(strsubcat_id)
      sql = "
      SELECT
        main_props.strsubcat_id,
        main_props_prop_names.*,
        prop_names.title,
        uoms.title as uom_title
      FROM main_props
        LEFT JOIN main_props_prop_names ON main_props.id = main_props_prop_names.main_prop_id
        LEFT JOIN prop_names ON main_props_prop_names.prop_name_id = prop_names.id
        LEFT JOIN uoms ON prop_names.uom_id = uoms.id
      WHERE main_props.strsubcat_id = #{strsubcat_id};
    "
      rows = ActiveRecord::Base.connection.execute(sql)
      rows
    end

  end

end