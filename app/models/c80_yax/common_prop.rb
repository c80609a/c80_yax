module C80Yax
  class CommonProp < ActiveRecord::Base
    belongs_to :strsubcat
    has_and_belongs_to_many :prop_names

    include C80Yax::Concerns::Props::Parsable

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
        c80_yax_common_props.strsubcat_id,
        c80_yax_common_props_prop_names.*,
        c80_yax_prop_names.title,
        c80_yax_uoms.title as uom_title
      FROM c80_yax_common_props
        LEFT JOIN c80_yax_common_props_prop_names ON c80_yax_common_props.id = c80_yax_common_props_prop_names.common_prop_id
        LEFT JOIN c80_yax_prop_names ON c80_yax_common_props_prop_names.prop_name_id = c80_yax_prop_names.id
        LEFT JOIN c80_yax_uoms ON c80_yax_prop_names.uom_id = c80_yax_uoms.id
      WHERE c80_yax_common_props.strsubcat_id = #{strsubcat_id};
    "
      rows = ActiveRecord::Base.connection.execute(sql)
      rows

    end

    # Выдать стуктуру, годную для обработки для view,
    # в которой содержатся данные характеристиках предмета.
    # +strsubcat_id+ подкатегория, которой принадлежит Товар
    # +item_as_hash+ это результат запроса к runtime таблице

    def self.get_props_parsed(strsubcat_id, item_as_hash)
      rows = self.get_props_for_strsubcat(strsubcat_id)
      self.parse_sql_props(rows, item_as_hash)
    end

  end

end