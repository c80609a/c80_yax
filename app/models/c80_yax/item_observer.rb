module C80Yax
  # noinspection RubyResolve
  class ItemObserver < ActiveRecord::Observer

    # Админ создаёт вещь:
    #   • в таблице типа str_111_items должна появиться строка, описывающая эту вещь
    def after_commit(item)
      Rails.logger.debug "[TRACE] <ItemObserver.after_commit> Создан предмет '#{item.title}'."
      StrsubcatRuntimeTables.table_check_and_build(item.strsubcat)
      StrsubcatRuntimeTables.table_fill(item.strsubcat.id) # TODO-5:: оптимизировать: не надо совершать операцию "заполнить таблицу", надо совершить операцию "вставлять в таблицу строку"
    end

    # Админ обновляет вещь:
    #
    def after_update(item)
      Rails.logger.debug "[TRACE] <ItemObserver.after_update> item.title = #{item.title}"
      StrsubcatRuntimeTables.item_update(item.strsubcat.id,item.id)
    end

    # Админ удаляет вещь:
    # • (средствами рельсы) из таблицы item_props должны исчезнуть свойства этой вещи
    # • из таблицы типа str_111_items должна исчезнуть строка, описывающая эту вещь
    def after_destroy(item)
      StrsubcatRuntimeTables.item_drop(item.strsubcat.id, item.id)
    end


  end
end