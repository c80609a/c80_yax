module C80Yax

  module DataHelper
    # хелпер, помогающий с выборкой данных для товаров из категории "строительные материалы"
    module StroyMatDataHelper

      include ActiveRecord

      # собрать все значения свойства prop_name_id из подкатегории sub_cat, например:
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
      #
      def stdh_collect_all_values(prop_name_id, sub_cat_id)

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

        #     >> stdh_get_strsubcat_propnames(1)
        # <stdh_get_strsubcat_propnames> BEGIN
        #    (0.2ms)
        #     SELECT
        #       `c80_yax_prop_names`.`id`,
        #       `c80_yax_prop_names`.`title`,
        #       `c80_yax_prop_names`.`is_excluded_from_filtering`,
        #       `c80_yax`.`title` as uom_title
        #     FROM `c80_yax_prop_names`
        #       INNER JOIN `c80_yax_prop_names_strsubcats` ON `c80_yax_prop_names`.`id` = `c80_yax_prop_names_strsubcats`.`prop_name_id`
        #       LEFT OUTER JOIN c80_yax_uoms ON c80_yax_uoms.id = prop_names.uom_id
        #     WHERE `c80_yax_prop_names_strsubcats`.`strsubcat_id` = 1;
        #
        # {"id"=>18, "title"=>"Цена за шт.", "is_excluded_from_filtering"=>1, "uom_title"=>"руб"}
        # {"id"=>19, "title"=>"Цена за шт. (старая)", "is_excluded_from_filtering"=>1, "uom_title"=>"руб"}
        # {"id"=>20, "title"=>"Цена за м²", "is_excluded_from_filtering"=>1, "uom_title"=>"руб"}
        # {"id"=>21, "title"=>"Цена за м² (старая)", "is_excluded_from_filtering"=>1, "uom_title"=>"руб"}
        # {"id"=>23, "title"=>"Размер", "is_excluded_from_filtering"=>0, "uom_title"=>nil}
        # {"id"=>24, "title"=>"Страна", "is_excluded_from_filtering"=>0, "uom_title"=>nil}
        # {"id"=>25, "title"=>"Прочность на сжатие", "is_excluded_from_filtering"=>0, "uom_title"=>"кгс/см²"}
        # {"id"=>26, "title"=>"Коэффициент теплопроводности", "is_excluded_from_filtering"=>0, "uom_title"=>"Вт/м×°C"}
        # {"id"=>27, "title"=>"Марка по морозостойкости", "is_excluded_from_filtering"=>0, "uom_title"=>nil}
        # {"id"=>28, "title"=>"Водопоглощение", "is_excluded_from_filtering"=>0, "uom_title"=>"%"}
        # {"id"=>29, "title"=>"Цвет", "is_excluded_from_filtering"=>0, "uom_title"=>nil}
        # {"id"=>30, "title"=>"Пустотность", "is_excluded_from_filtering"=>0, "uom_title"=>nil}
        # {"id"=>31, "title"=>"Формовка", "is_excluded_from_filtering"=>0, "uom_title"=>nil}
        # {"id"=>32, "title"=>"Поверхность", "is_excluded_from_filtering"=>0, "uom_title"=>nil}
        # {"id"=>33, "title"=>"Вес", "is_excluded_from_filtering"=>0, "uom_title"=>nil}
        # {"id"=>34, "title"=>"Количество на поддоне", "is_excluded_from_filtering"=>1, "uom_title"=>"шт"}
        # {"id"=>35, "title"=>"Тип кирпича", "is_excluded_from_filtering"=>0, "uom_title"=>nil}
        # {"id"=>36, "title"=>"Бренд", "is_excluded_from_filtering"=>0, "uom_title"=>nil}
        # {"id"=>37, "title"=>"Артикул", "is_excluded_from_filtering"=>1, "uom_title"=>nil}
        # {"id"=>38, "title"=>"Формат", "is_excluded_from_filtering"=>0, "uom_title"=>nil}
        # <stdh_get_strsubcat_propnames> END

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

end