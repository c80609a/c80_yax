module C80Yax

  # хелпер, помогающий с выборкой данных для товаров из категории "строительные материалы"
  module DataHelper

    include ActiveRecord

    # собрать все значения свойства prop_name_id из подкатегории sub_cat
    def stdh_collect_all_values(prop_name_id, sub_cat_id)

      # +---------------------+
      # | prop_23             |
      # +---------------------+
      # | 215 x 102 x 65 мм   |
      # | 215 x 48 x 65 мм    |
      # | 250 x 85 x 65 мм    |
      # | 254 x 95 x 65 мм    |
      # | 290 x 90 x 52 мм    |
      # | 528 x 108 x 37 мм   |
      # +---------------------+

      table_name  = "strcat_#{sub_cat_id}_items"
      column_name = "prop_#{prop_name_id}"

      sql = "
          SELECT #{table_name}.#{column_name}
          FROM #{table_name}
          GROUP by #{table_name}.#{column_name};
        "

      ActiveRecord::Base.connection.execute(sql) # => records array

    end

    # выдать все характеристики, присущие данной категории, вместе с единицами измерений
    def stdh_get_strsubcat_propnames(strsubcat_id)

      # +----+----------------+----------------------------+-----------+
      # | id | title          | is_excluded_from_filtering | uom_title |
      # +----+----------------+----------------------------+-----------+
      # |  2 | Цена           |                          0 | руб.      |
      # |  3 | Объём          |                          0 | мл        |
      # |  4 | Вкус           |                          0 | NULL      |
      # |  5 | VG/PG          |                          0 | NULL      |
      # |  6 | Никотин        |                          0 | мг        |
      # |  7 | Страна         |                          0 | NULL      |
      # | 19 | Бренд          |                          0 | NULL      |
      # +----+----------------+----------------------------+-----------+

      # {"id"=>2, "title"=>"Цена", "is_excluded_from_filtering"=>0, "uom_title"=>"руб."},
      # {"id"=>3, "title"=>"Объём", "is_excluded_from_filtering"=>0, "uom_title"=>"мл"},
      # {"id"=>4, "title"=>"Вкус", "is_excluded_from_filtering"=>0, "uom_title"=>nil},
      # {"id"=>5, "title"=>"VG/PG", "is_excluded_from_filtering"=>0, "uom_title"=>nil},
      # {"id"=>6, "title"=>"Никотин", "is_excluded_from_filtering"=>0, "uom_title"=>"мг"},
      # {"id"=>7, "title"=>"Страна", "is_excluded_from_filtering"=>0, "uom_title"=>nil},
      # {"id"=>19, "title"=>"Бренд", "is_excluded_from_filtering"=>0, "uom_title"=>nil}

      Rails.logger.debug '[TRACE] <stdh_get_strsubcat_propnames> BEGIN'
      sql = "
          SELECT
            `c80_yax_prop_names`.`id`,
            `c80_yax_prop_names`.`title`,
            `c80_yax_prop_names`.`is_excluded_from_filtering`,
            `c80_yax_uoms`.`title` as `uom_title`
          FROM `c80_yax_prop_names`
            INNER JOIN `c80_yax_prop_names_strsubcats` ON `c80_yax_prop_names`.`id` = `c80_yax_prop_names_strsubcats`.`prop_name_id`
            LEFT OUTER JOIN `c80_yax_uoms` ON `c80_yax_uoms`.`id` = `c80_yax_prop_names`.`uom_id`
          WHERE `c80_yax_prop_names_strsubcats`.`strsubcat_id` = #{strsubcat_id};
        "

      result = []
      rows   = Base.connection.execute(sql)
      rows.each(:as => :hash) do |row|
        result << row
      end

      Rails.logger.debug '[TRACE] <stdh_get_strsubcat_propnames> END'
      result

    end

  end

end