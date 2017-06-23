# В задачи класса входят:
#
#     * создавать\удалять\заполнять таблицы вида `c80_yax_strcat_#{NN}_items"
#
#
#
#

class StrsubcatRuntimeTables

    def self.table_fill(strsubcat_id) # strh_table_fill

      # NOTE:: [columns] эти столбцы должны соответствовать (комментарий как wiki)

      # [0] item_props.prop_name_id,
      # [1] prop_names.title AS prop_name_title,
      # [2] item_props.value,
      # [3] items.id AS item_id,
      # [4] items.title as item_title,
      # [5] items.is_main,
      # [6] items.is_hit,
      # [7] items.is_sale,
      # [8] strsubcats.id AS strsubcat_id,
      # [9] strsubcats.slug AS strsubcat_slug
      # [10] vendors.id as vendor_id
      # [11] vendors.title as vendor_title - дублирующий столбец: чтобы не совершать
      #                                      лишних запросов за vendor.title в методе hash_sql_make
      # [12] items.full_desc
      # [13] items.image
      # [14] items.is_ask_price
      # [15] `c80_yax_items`.`is_gift`,
      # [16] `c80_yax_items`.`is_starting`,
      # [17] `c80_yax_items`.`is_available`
      # выбираем свойства предметов вместе с инфой о предметах, которым они принадлежат

      # <editor-fold desc="# составляем и выполняем sql запрос">

      # NOTE:: [columns] эти столбцы должны соответствовать

      sql = "
            SELECT
              `c80_yax_item_props`.`prop_name_id`,
              `c80_yax_prop_names`.`title` AS prop_name_title,
              `c80_yax_item_props`.`value`,
              `c80_yax_items`.`id`         AS item_id,
              `c80_yax_items`.`title`      AS item_title,
              `c80_yax_items`.`is_main`,
              `c80_yax_items`.`is_hit`,
              `c80_yax_items`.`is_sale`,
              `c80_yax_strsubcats`.`id`    AS strsubcat_id,
              `c80_yax_strsubcats`.`slug`  AS strsubcat_slug,
              `c80_yax_vendors`.`id`       AS vendor_id,
              `c80_yax_vendors`.`title`    AS vendor_title,
              `c80_yax_items`.`full_desc`,
              `c80_yax_items`.`image`,
              `c80_yax_items`.`is_ask_price`,
              `c80_yax_items`.`is_gift`,
              `c80_yax_items`.`is_starting`,
              `c80_yax_items`.`is_available`
            FROM `c80_yax_items`
              INNER JOIN `c80_yax_strsubcats` ON `c80_yax_strsubcats`.`id` = `c80_yax_items`.`strsubcat_id`
              LEFT JOIN `c80_yax_item_props` ON `c80_yax_item_props`.`item_id` = `c80_yax_items`.`id`
              LEFT JOIN `c80_yax_prop_names` ON `c80_yax_prop_names`.`id` = `c80_yax_item_props`.`prop_name_id`
              LEFT JOIN `c80_yax_items_vendors` ON `c80_yax_items_vendors`.`item_id` = `c80_yax_items`.`id`
              LEFT JOIN `c80_yax_vendors` ON `c80_yax_vendors`.`id` = `c80_yax_items_vendors`.`vendor_id`
            WHERE (`c80_yax_strsubcats`.`id` = #{strsubcat_id})
      "
        records = ActiveRecord::Base.connection.execute(sql)
        records
      # </editor-fold>

      # 1. заполняем хэш объектами для составления sql-команд INSERT
      hash_sql = self.hash_sql_make(records, strsubcat_id)

      Rails.logger.debug '[TRACE] <StrsubcatRuntimeTables.table_fill> Начинаем заполнять таблицу:'
      self.hash_sql_execute(hash_sql)
      Rails.logger.debug '[TRACE] <StrsubcatRuntimeTables.table_fill> END'

    end

=begin
    # выдать список вещей из указанной подкатегории (возможно, применяя фильтры)
    def strh_items_filter(strsubcat_id, page, per_page, sorting_type, filter_params = {})

      # Rails.logger.debug "page = #{page}"
      # Rails.logger.debug "per_page = #{per_page}"

      table_name = "strcat_#{strsubcat_id}_items"
      Rails.logger.debug "[TRACE] <strh_filter_items> START: #{table_name}, sorting_type = #{sorting_type}, filter_params = #{filter_params.to_json}"

      if ActiveRecord::Base.connection.table_exists?(table_name)

        ob = compose_sql_order_by(strsubcat_id,sorting_type)
        w = compose_where_sql(filter_params, table_name)
        sql = "SELECT * FROM #{table_name}#{w}#{ob}"

        # SELECT * FROM strcat_1_items
        # WHERE
        #       strcat_1_items.prop_1 = '5 кг'
        #        AND
        #       strcat_1_items.prop_3 = '1450 кг/м3';

        items = Item.paginate_by_sql(sql, :page => page, :per_page => per_page)

        Rails.logger.debug "[TRACE] <strh_filter_items> END"
      else
        # сюда попадаем в исключительной ситуации - ошибка т.е.
        Rails.logger.debug "[ERROR] <strh_filter_items> Нет таблицы с именем #{table_name}"
        items = Item.all.paginate(:page => 1, :per_page => 0)
      end
      items

    end
=end

=begin
    # от метода ожидается результат: хэш вида {"3"=>["900 кг/м3", "1450 кг/м3"], "5"=>["300 мм", "2300 x 1250 x 900"], "9"=>["20 %", "13%", "12%"]}
    def strh_collect_allowed_vals(strsubcat_id,filter_params={})
      # filter_params = {"1"=>"5 кг", "3"=>"-1", "5"=>"-1", "9"=>"-1"}

      table_name = "strcat_#{strsubcat_id}_items"
      if ActiveRecord::Base.connection.table_exists?(table_name)

        s = 'SET SESSION group_concat_max_len = 102400000'
        ActiveRecord::Base.connection.execute(s)

        w = compose_where_sql(filter_params, table_name)
        g = compose_group_concat_sql(filter_params)
        sql = "SELECT id#{g} FROM #{table_name}#{w}"
        records_array = ActiveRecord::Base.connection.exec_query(sql)
        hsh = records_array.to_hash
        # Rails.logger.debug "<strh_collect_allowed_vals> Промежуточный hash: #{hsh}"

        # Rails.logger.debug "strh_collect_allowed_vals:: #{hsh}"
        # [{"id"=>3, "3"=>"95 г/м3,1450 кг/м3", "5"=>"2500 x 1200 x 800,2500 x 1200 x 800", "9"=>"0.51 %,0.51 %"}]

        # посчитаем, сколько фильтров используется
        # если используется один фильтр - зафиксируе его key
        # чтобы для него собрать все возможные значения
        # чтобы в <select>`е были доступны все <options>
        # NOTE:: этот метод вообще работает?
        prop_id = is_only_one_filter_use(filter_params={})
        unless prop_id == -1
          # Rails.logger.debug "<strh_collect_allowed_vals> Фильтруем только по одному признаку."
          hsh[0][prop_id.to_s] = strh_collect_all_vals(prop_id, table_name)
        end

        res = {}
        hsh[0].each_key do |key|
          unless key["id"]
            res[key] = hsh[0][key].split('----') if hsh[0][key].present?
          end
        end
        Rails.logger.debug "[TRACE] <strh_collect_allowed_vals> Собрали, результат: #{res}"
        # {"3"=>["900 кг/м3", "1450 кг/м3", "1450 кг/м3"], "5"=>["300 мм", "2300 x 1250 x 900", "2300 x 1250 x 900"], "9"=>["20 %", "13%", "12%"]}
      else
        res = {}
      end

      res

    end
=end

=begin
    # Для подкатегории strsubcat_id соберёт список всех характеристик,
    # по которым строится фильтр панель.
    #
    # Например: на вход подаётся `filter_params = {"36"=>"Идеальный камень"}`,
    # результат будет: {"36"=>"Идеальный камень", "29"=>"-1", "32"=>"-1"}
    # и результат будет означать, что данная подкатегория может фильтроваться
    # по 3-ём характеристикам, и одна из них в данный момент выставлена в селектах.
    #
    # 20170616
    # NOTE:: как stroy_mat_render_helper::sth_render_prop_names
    def strh_collect_all_filter_vals(strsubcat_id, filter_params={})
      Rails.logger.debug "[TRACE] <strh_collect_all_filter_vals!> before: #{filter_params}"

      result = filter_params.clone
      strsubcat = Strsubcat.find(strsubcat_id)

      # собираем массив всех имён свойств подкатегории:
      #   если такое свойство уже есть в filter_params - пропускаем
      #   если свойство исключено из фильтрации - пропускаем
      ar_prop_names = strsubcat.prop_names
      ar_prop_names.each do |prop_name|
        pid = prop_name.id.to_s
        unless result[pid].present?
          result[pid] = '-1' unless prop_name.is_excluded_from_filtering
        end
      end

      Rails.logger.debug "[TRACE] <strh_collect_all_filter_vals!> after: #{filter_params}"
      result

    end
=end

    # создаёт таблицу под все вещи подкатегории, если такой таблицы нету в базе
    def self.table_check_and_build(strsubcat) # strh_table_check_and_build

      # по-умолчанию в результате исполнения метода - таблицу создавать не надо
      # noinspection RubyUnusedLocalVariable
      mark_create_table = false

      runtime_table_name = "c80_yax_strcat_#{strsubcat.id}_items"

      # <editor-fold desc="# Сначала составим список айдишников всех свойств, присущих данной категории">
      # выбрать из базы айдишники всех свойств, присущих данной категории
      # по сути дела, тоже самое, что и strsubcat.prop_names
      sql = "
          SELECT `c80_yax_prop_names`.`id`
          FROM `c80_yax_prop_names`
          INNER JOIN `c80_yax_prop_names_strsubcats` ON `c80_yax_prop_names`.`id` = `c80_yax_prop_names_strsubcats`.`prop_name_id`
          WHERE `c80_yax_prop_names_strsubcats`.`strsubcat_id` = #{strsubcat.id}
      "
      records = ActiveRecord::Base.connection.execute(sql)

      propnames_ids = []
      records.each do |r|
        propnames_ids << r[0].to_i
      end
      # </editor-fold>

      # Теперь определимся, нужно ли дропнуть и создать таблицу
      if ActiveRecord::Base.connection.table_exists? runtime_table_name
        Rails.logger.debug "[TRACE] <StrsubcatRuntimeTables.table_check_and_build> Таблица уже существует: #{runtime_table_name}"

        # <editor-fold desc="# совпадают ли столбцы runtime таблицы и свойства?">
        # проверим, совпадают ли столбцы свойств в runtime таблице со списком свойств, присущих данной категории:
        # если какого-то свойства нет в столбцах - дропнем таблицу и создадим её заново
        # если есть лишний столбец в таблице - дропнем таблицу и создадим её заново
        Rails.logger.debug '[TRACE] <StrsubcatRuntimeTables.table_check_and_build> Проверим соответствие столбцов свойствам.'

        # получим список столбцов и извлечём из него айдишники свойств в массив +actual_props_ids+
        sql_describe = "DESCRIBE #{runtime_table_name}"
        records = ActiveRecord::Base.connection.execute(sql_describe)
        actual_props_ids = []
        records.each do |row|
          actual_props_ids << row[0][/\d+/].to_i if row[0]['prop_']
        end

        mark_create_table = actual_props_ids.sort != propnames_ids.sort
        Rails.logger.debug "[TRACE] <StrsubcatRuntimeTables.table_check_and_build> Сравним propnames_ids = #{propnames_ids} и actual_props_ids = #{actual_props_ids}."
        Rails.logger.debug "[TRACE] <StrsubcatRuntimeTables.table_check_and_build> mark_create_table = #{mark_create_table}."
        # </editor-fold>

        # если не совпадают - дропнем таблицу
        if mark_create_table
          self.table_drop(strsubcat)
        end

      else
        Rails.logger.debug "[TRACE] <check_and_build_table> Таблица не существует, создаём: #{runtime_table_name}"
        mark_create_table = true
      end

      # Если таблицу надо создать - создаём
      if mark_create_table
        self.table_create(runtime_table_name, propnames_ids)
      end

    end

    # враппер метода ActiveRecord::Migration.create_table
    # создаёт таблицу с именем strcat_#{strsubcat_id}_items
    # со столбцами, описанными в массиве props_names_list (имя столбца вида prop_#{item})
    def self.table_create(runtime_table_name, propnames_ids) # strh_table_create
      Rails.logger.debug "[TRACE] <StrsubcatRuntimeTables.table_create> BEGIN. propnames_ids = #{propnames_ids}"

      ActiveRecord::Migration.create_table(runtime_table_name, :options => 'COLLATE=utf8_unicode_ci') do |t|

        # NOTE:: [columns] эти столбцы должны соответствовать (создание новой таблицы)

        t.integer :item_id
        t.string :item_title
        t.boolean :is_main
        t.boolean :is_hit
        t.boolean :is_sale
        t.integer :strsubcat_id
        t.string :strsubcat_slug
        t.integer :vendor_id
        t.text :full_desc
        t.string :image
        t.boolean :is_ask_price
        t.boolean :is_gift
        t.boolean :is_starting
        t.boolean :is_available

        t.index :item_id, unique: true

        # т.к. сортировка средствами SQL (ORDER BY) нам
        # нужна только для цен, то только столбцы для
        # цен делаем числами. Остальное - храним, как строки.
        propnames_ids.each do |prop_name_id|
          is_decimal_column = C80Yax::PropName.find(prop_name_id).is_normal_price
          if is_decimal_column
            t.decimal "prop_#{prop_name_id}", :precision => 8, :scale => 2
          else
            t.string "prop_#{prop_name_id}"
          end

        end

      end

      Rails.logger.debug '[TRACE] <StrsubcatRuntimeTables.table_create> END'

    end

    def self.table_drop(strsubcat) # strh_table_drop
      runtime_table_name = "c80_yax_strcat_#{strsubcat.id}_items"
      if ActiveRecord::Base.connection.table_exists?(runtime_table_name)
        Rails.logger.debug "[TRACE] <StrsubcatRuntimeTables.table_drop> Удаляем таблицу: table_name = #{runtime_table_name}"
        ActiveRecord::Migration.drop_table(runtime_table_name)
        Rails.logger.debug '[TRACE] <StrsubcatRuntimeTables.table_drop> END'
      end
    end

    # удаляем из таблицы item_props те строки, у которых strsubcat_id == ID
    # и чьё prop_name_id входит в список свойств LIST
    # вызывается только в методе StrsubcatSweeper.after_update
    def self.check_and_clean_item_props(strsubcat) # strh_check_and_clean_item_props
      list = strsubcat.get_list_removed_props

      if list.count > 0
        Rails.logger.debug '[TRACE] <StrsubcatRuntimeTables.check_and_clean_item_props> Чистим item_props.'
        # 1.1. Сначала составим список свойств, которые надо удалить.

        sql = "
        SELECT
          `c80_yax_item_props`.`id`,
          `c80_yax_item_props`.`prop_name_id`,
          `c80_yax_prop_names`.`title` AS prop_name_title,
          `c80_yax_item_props`.`value`,
          `c80_yax_items`.`id` AS item_id,
          `c80_yax_items`.`title` as item_title,
          `c80_yax_items`.`is_main`,
          `c80_yax_items`.`is_hit`,
          `c80_yax_items`.`is_sale`,
          `c80_yax_strsubcats`.`id` AS strsubcat_id,
          `c80_yax_strsubcats`.`slug` AS strsubcat_slug
        FROM `c80_yax_items`
          INNER JOIN `c80_yax_strsubcats` ON `c80_yax_strsubcats`.`id` = `c80_yax_items`.`strsubcat_id`
          LEFT JOIN `c80_yax_item_props` ON `c80_yax_item_props`.`item_id` = `c80_yax_items`.`id`
          LEFT JOIN `c80_yax_prop_names` ON `c80_yax_prop_names`.`id` = `c80_yax_item_props`.`prop_name_id`
        WHERE `c80_yax_strsubcats`.`id` = #{ strsubcat.id }
        AND `c80_yax_prop_name_id` IN (#{ list.join(',')})
      "

        records = ActiveRecord::Base.connection.execute(sql)

        # 1.2. Составим список айдишников свойств для удаления
        item_props_ids = []
        records.each do |row|
          item_props_ids << row[0]
        end

        # 2. Теперь на основе списка свойств, которые надо удалить, составим запрос, который удалит эти свойства.
        if item_props_ids.count > 0
          sql = "
        DELETE FROM `c80_yax_item_props`
        WHERE `id` IN (#{ item_props_ids.join(',') })
      "

          ActiveRecord::Base.connection.execute(sql)
        end

        Rails.logger.debug '[TRACE] <StrsubcatRuntimeTables.check_and_clean_item_props> END'
      end

    end

    # из таблицы типа strcat_111_items удалить строку, описывающую вещь item_id
    def self.item_drop(strsubcat_id, item_id) # strh_item_drop
      runtime_table_name = "c80_yax_strcat_#{strsubcat_id}_items"
      Rails.logger.debug "[TRACE] <StrsubcatRuntimeTables.item_drop> Удаляем вещь id = #{item_id} из таблицы `#{runtime_table_name}`."
      if ActiveRecord::Base.connection.table_exists?(runtime_table_name)
        sql = "
        DELETE FROM #{runtime_table_name}
        WHERE item_id = #{item_id}
        "

        ActiveRecord::Base.connection.execute(sql)
      end
    end

=begin
    # в таблице типа strcat_111_items обновить поля строки, описывающую вещь item_id
    def strh_item_update(strsubcat_id,item_id)
      Rails.logger.debug "[TRACE] <strh_item_update> В таблице strcat_#{strsubcat_id}_items обновим данные о товаре item_id = #{item_id}"
      # сначала соберём все свойства вещи
      sql = "
    SELECT
      item_props.prop_name_id,
      prop_names.title AS prop_name_title,
      item_props.value,
      items.id AS item_id,
      items.title as item_title,
      items.is_main,
      items.is_hit,
      items.is_sale,
      strsubcats.id AS strsubcat_id,
      strsubcats.slug AS strsubcat_slug,
      vendors.id as vendor_id,
      vendors.title as vendor_title,
      items.full_desc,
      items.image,
      items.is_ask_price
    FROM `items`
      INNER JOIN `strsubcats` ON `strsubcats`.`id` = `items`.`strsubcat_id`
      LEFT JOIN `item_props` ON `item_props`.`item_id` = `items`.`id`
      LEFT JOIN prop_names ON prop_names.id = item_props.prop_name_id
      LEFT JOIN items_vendors ON items_vendors.item_id = `items`.`id`
      LEFT JOIN vendors ON vendors.id = `items_vendors`.`vendor_id`
    WHERE (strsubcats.id = #{strsubcat_id})
    AND items.id = #{item_id};
    "
      records = ActiveRecord::Base.connection.execute(sql)

      # составим SQL команду
      hash_sql = self.hash_sql_make(records,strsubcat_id)

      #-> удалим старую строку
      sql = "DELETE FROM `strcat_#{strsubcat_id}_items` WHERE item_id = #{item_id}"
      ActiveRecord::Base.connection.execute(sql)

      #-> выполним SQL команду : вставим строку с обновлёнными значениями
      hash_sql_execute(hash_sql)

      Rails.logger.debug "[TRACE] <strh_item_update> END"
    end
=end

=begin
    # выдать строку, описывающую товар с id=item_id из подкатегории id=strsubcat_id
    # {"id"=>84, "item_id"=>1, "item_title"=>"Кирпич облицовочный Labassa стандарт качества Qbricks", "is_main"=>0, "is_hit"=>0, "is_sale"=>1, "strsubcat_slug"=>"kirpich", "prop_18"=>"13,85", "prop_19"=>"15", "prop_20"=>"16", "prop_21"=>"18", "prop_23"=>"250 x 85 x 65 мм", "prop_24"=>"Румыния", "prop_25"=>"150", "prop_26"=>"0,60", "prop_27"=>"F300", "prop_28"=>"12,8", "prop_29"=>"красный", "prop_30"=>"пустотелый", "prop_31"=>"пластичное формование", "prop_32"=>"гладкая", "prop_33"=>"1,5", "prop_34"=>"458", "prop_35"=>"лицевой, фасадный", "prop_36"=>"Ibstock", "prop_37"=>"GE-02 A", "prop_38"=>"BS"}
    def strh_item_get(strsubcat_id,item_id)
      # http://stackoverflow.com/questions/5760100/why-does-rails-3-with-mysql2-gem-activerecordbase-connection-executesql-retu
      sql = "SELECT * FROM strcat_#{strsubcat_id}_items WHERE item_id = #{item_id}"
      rows = ActiveRecord::Base.connection.execute(sql)
      # т.к. результат может быть только в виде одного объекта - вернём первую попавшуюся строку
      rows.each(:as => :hash) do |row|
        # Rails.logger.debug "#{row['item_title']}"
        return row
      end
    end
=end

    private

=begin
    def compose_where_sql(filter_params={},table_name)
      result = []
      a = filter_params
      a.each_key do |key|
        result << "#{table_name}.prop_#{key} = '#{a[key]}'" unless a[key] == '-1' # strcat_1_items.prop_1 = '5 кг'
      end
      if result.count > 0
        " WHERE #{result.join(' AND ')}"
      else
        ""
      end
    end
=end

=begin
    # от метода ожидается результат: строка вида ", GROUP_CONCAT(prop_3 SEPARATOR '----') all_prop_3, GROUP_CONCAT(prop_5 SEPARATOR '----') all_prop_5"
    def compose_group_concat_sql(filter_params={})
      # filter_params = {"1"=>"5 кг", "3"=>"-1", "5"=>"-1", "9"=>"-1"}

      res = []
      filter_params.each_key do |key|
        res << "GROUP_CONCAT(prop_#{key} SEPARATOR '----') `#{key}`" # if filter_params[key].to_s["-1"]
      end
      ", #{res.join(", ")}"

    end
=end

    # NOTE:: этот метод вообще работает?
    def is_only_one_filter_use(filter_params={})

      c = filter_params.count
      key_filter_used = -1
      filter_params.each_key do |key|
        if filter_params[key].to_s["-1"]
          c -= 1
        else
          key_filter_used = key
        end
      end

      if c == 1
        only_one_filter_used = true
      else
        only_one_filter_used = false
        key_filter_used = -1
      end

      Rails.logger.debug "[TRACE] <StrItemsHelper.is_only_one_filter_use> filters in use = #{c}; only_one_filter_used = #{only_one_filter_used}, key_filter_used = #{key_filter_used}"
      key_filter_used

    end

=begin
    # собираем все доступные значения для селекта
    def strh_collect_all_vals(prop_id,table_name)
      # SELECT
      # id,
      # GROUP_CONCAT(prop_3   SEPARATOR '----') all_values_3
      # FROM strcat_1_items;

      s = 'SET SESSION group_concat_max_len = 102400000'
      ActiveRecord::Base.connection.execute(s)

      sql = "SELECT id, GROUP_CONCAT(prop_#{prop_id} SEPARATOR '----') all_values_#{prop_id} FROM #{table_name}"
      records_array = ActiveRecord::Base.connection.exec_query(sql)
      hsh = records_array.to_hash
      # [{"id"=>1, "3"=>"95 г/м3,1450 кг/м3"}]

      res = {}
      hsh[0].each_key do |key|
        unless key["id"]
          res = hsh[0][key]
          break
        end
      end

      Rails.logger.debug "<strh_collect_all_vals> Cобрали все доступные значения для селекта id=#{prop_id}: res = #{res}"
      res

    end
=end

    def self.hash_sql_make(records, strsubcat_id)
      Rails.logger.debug "[TRACE] <StrsubcatRuntimeTables.hash_sql_make> Составляем SQL для обновления/создания записи в runtime-таблице `c80_yax_strcat_#{strsubcat_id}_items`. records.count = #{records.count}."

      hash_sql = {}

      records.each do |item_prop|

        prop_name_id = item_prop[0]
        prop_value = item_prop[2]
        item_id = item_prop[3]
        is_ask_price = item_prop[14]


        # <editor-fold desc="# производим магические манипуляции с Производителем">
        # если это свойство "бренд" -
        # то игнорируем значение, которое лежит в таблице itep_props
        vendor_id = item_prop[10]
        vendor_title = item_prop[11]
        if prop_name_id == 36 # NOTE-HARD-CODE-PROP-NAME
          prop_value = vendor_title
          if prop_value.blank?
            prop_value = 'Не указан'
          end
        end

        # корректируем значение
        unless vendor_id.present?
          vendor_id = -1
        end
        # </editor-fold>

        # <editor-fold desc="# манипулируем с is_ask_price">
        if is_ask_price.present?
          if is_price
            # если у товара is_ask_price = true, то игнорируем значение, которое лежит в таблице
            # item_props и в prop_value помещаем максимально возможное значение, чтобы товар, при сортировке
            # по цене, уходил в самый конец списка
            # 20170402: также опытным путём выяснилось, что надо также обновлять значение
            # в таблице items_props
            if is_ask_price.to_i == 1
              Rails.logger.debug '[TRACE] <StrsubcatRuntimeTables.hash_sql_make> is_ask_price=TRUE.'
              prop_value = 999999
              # и обновляем значение в таблице items_props
              item_prop_price = C80Yax::ItemProp.where(:item_id => item_id).where(:prop_name_id => prop_name_id)
              if item_prop_price.count > 0
                item_prop_price.first.update_column(:value, 999999)
              end
            end
          end
        else
          # защищаемся от ошибки "Mysql2::Error: Incorrect integer value: '' for column 'is_ask_price'"
          is_ask_price = 0
        end
        # </editor-fold>

        # кэшируем первый раз
        unless hash_sql[item_id].present?
          # Rails.logger.debug "\t new hash"
          hash_sql[item_id] = {
              prop_names_ids: %w'item_id item_title is_main is_hit is_sale strsubcat_id strsubcat_slug vendor_id full_desc image is_ask_price is_gift is_starting is_available',
              values: [item_id,item_prop[4],item_prop[5],item_prop[6],item_prop[7],item_prop[8],item_prop[9],vendor_id,item_prop[12],item_prop[13], is_ask_price, item_prop[15], item_prop[16], item_prop[17]],
              sql: "INSERT INTO `c80_yax_strcat_#{strsubcat_id}_items` ({props}) VALUES ({values})"
          }
        end

        # byebug
        Rails.logger.debug "[TRACE] <StrsubcatRuntimeTables.hash_sql_make> prop_name_id: #{prop_name_id}, prop_value: #{prop_value}."

        # добавляем в кэш
        hash_sql[item_id][:prop_names_ids] << "prop_#{prop_name_id}"
        hash_sql[item_id][:values] << prop_value

      end

      # 2. обходим этот хэш, для каждого объекта формируем sql-команду на основе данных объекта хэша
      hash_sql.each_key do |key|
        obj = hash_sql[key]
        p = "`#{obj[:prop_names_ids].join("`,`")}`"
        v = "'#{obj[:values].join("','")}'"
        obj[:sql] = obj[:sql].gsub(/\{props\}/,p)
        obj[:sql] = obj[:sql].gsub(/\{values\}/,v)
      end
      hash_sql

    end

    def self.hash_sql_execute(hash_sql)

      # INSERT INTO Table1
      # (`id`, `name`)
      # VALUES
      #   (1, 'foo'),
      #   (1, 'bar'),
      #   (1, 'foobar'),
      #   (2, 'foo'),
      #   (2, 'bar'),
      #   (2, 'foobar')
      #;
      hash_sql.each_key do |key|
        sql = hash_sql[key][:sql]
        # Rails.logger.debug sql
        begin
          ActiveRecord::Base.connection.execute(sql)
        rescue Exception => e
          Rails.logger.debug "[TRACE] <StrsubcatRuntimeTables.hash_sql_execute> #{e}"
        end
      end
    end

=begin
    # составить sql строку, которая прицепится к запросу выборки вещей
    # и будет содержать комаду вида:
    # "отсортировать по 'цене 1' по возрастанию или по убыванию"
    # Если у подкатегории нет "цены 1" - вернётся пустая строка
    def compose_sql_order_by(strsubcat_id,sorting_type)
      result = ""
      price_prop_id = PriceProp.gget_sort_pprop_for_strsubcat(strsubcat_id)
      if price_prop_id != ""
        asc_or_desc = SortingType.where(:sort_type => sorting_type).first.sql
        result = " ORDER BY prop_#{price_prop_id} #{asc_or_desc}"
      end
      Rails.logger.debug "<order_by_sql_make> Сортировка по 'цене 1': '#{result}'"
      result
    end
=end

end