module C80Yax
  class CommonProp < ActiveRecord::Base
    belongs_to :strsubcat
    has_and_belongs_to_many :prop_names

# +--------------+----------------+--------------+--------------------------------------------------------+---------------+
# | strsubcat_id | common_prop_id | prop_name_id | title                                                  | uom_title     |
# +--------------+----------------+--------------+--------------------------------------------------------+---------------+
# |            7 |              1 |           37 | Артикул                                                | NULL          |
# |            7 |              2 |           30 | Пустотность                                            | NULL          |
# |            7 |              3 |           38 | Формат                                                 | NULL          |
# |            7 |              4 |           23 | Размер                                                 | NULL          |
# |            7 |              5 |           36 | Бренд                                                  | NULL          |
# |            7 |              6 |           46 | Завод                                                  | NULL          |
# |            7 |              7 |           24 | Страна                                                 | NULL          |
# |            7 |              8 |           25 | Прочность на сжатие                                    | кгс/см²       |
# |            7 |              9 |           27 | Марка по морозостойкости                               | NULL          |
# |            7 |             10 |           28 | Водопоглощение                                         | %             |
# |            7 |             11 |           67 | Средняя плотность                                      | кг/м³         |
# |            7 |             12 |           70 | Класс средней плотности                                | NULL          |
# |            7 |             13 |           26 | Коэффициент теплопроводности                           | Вт/(м°C)      |
# |            7 |             14 |           71 | Коэффициент теплопроводности (условия эксплуатации A)  | Вт/(м°C)      |
# |            7 |             15 |           72 | Коэффициент теплопроводности (условия эксплуатации Б)  | Вт/(м°C)      |
# |            7 |             16 |           33 | Вес                                                    | кг            |
# |            7 |             17 |           34 | Количество на поддоне                                  | шт            |
# |            7 |             18 |           58 | Норма загрузки                                         | шт            |
# +--------------+----------------+--------------+--------------------------------------------------------+---------------+

    def self.get_props_for_strsubcat(strsubcat_id)
      sql = "
      SELECT
        common_props.strsubcat_id,
        common_props_prop_names.*,
        prop_names.title,
        uoms.title as uom_title
      FROM common_props
        LEFT JOIN common_props_prop_names ON common_props.id = common_props_prop_names.common_prop_id
        LEFT JOIN prop_names ON common_props_prop_names.prop_name_id = prop_names.id
        LEFT JOIN uoms ON prop_names.uom_id = uoms.id
      WHERE common_props.strsubcat_id = #{strsubcat_id};
    "
      rows = ActiveRecord::Base.connection.execute(sql)
      rows

    end

  end

end