module C80Yax
  class PrefixProp < ActiveRecord::Base
    belongs_to :strsubcat
    has_and_belongs_to_many :prop_names

    include C80Yax::Concerns::Props::Parsable

    # +--------------+----------------+--------------+--------------------------------------------------------+---------------+
    # | strsubcat_id | prefix_prop_id | prop_name_id | title                                                  | uom_title     |
    # +--------------+----------------+--------------+--------------------------------------------------------+---------------+
    # |            7 |              5 |           36 | Бренд                                                  | NULL          |
    # |            7 |              6 |           46 | Завод                                                  | NULL          |
    # +--------------+----------------+--------------+--------------------------------------------------------+---------------+

    def self.select_props_sql(strsubcat_id)
      sql = "
      SELECT
        c80_yax_prefix_props.strsubcat_id,
        c80_yax_prefix_props_prop_names.*,
        c80_yax_prop_names.title,
        c80_yax_uoms.title as uom_title
      FROM c80_yax_prefix_props
        LEFT JOIN c80_yax_prefix_props_prop_names ON c80_yax_prefix_props.id = c80_yax_prefix_props_prop_names.prefix_prop_id
        LEFT JOIN c80_yax_prop_names ON c80_yax_prefix_props_prop_names.prop_name_id = c80_yax_prop_names.id
        LEFT JOIN c80_yax_uoms ON c80_yax_prop_names.uom_id = c80_yax_uoms.id
      WHERE c80_yax_prefix_props.strsubcat_id = #{strsubcat_id};
    "
      rows = ActiveRecord::Base.connection.execute(sql)
      rows

    end

  end

end