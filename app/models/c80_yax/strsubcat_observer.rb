module C80Yax
  class StrsubcatObserver < ActiveRecord::Observer

    # Админ создаёт подкатегорию:
    #   • в базе должна создаться таблица вещей подкатегории типа str_111_items
    #     со столбцами - свойствами, присущ. подкатегории
    def after_create(strsubcat)
      Rails.logger.debug "[TRACE] <StrsubcatObserver.after_create> Создана подкатегория #{strsubcat.id}."
      # byebug
      StrsubcatRuntimeTables.table_check_and_build(strsubcat)
    end

    # Админ обновляет подкатегорию:
    #   • если были изменены свойства, присущ. подкатегории:
    #         • удаляем таблицу вещей подкатегории типа str_111_items
    #         • если свойства, присущ. подкатегории, были удалены - чистим от них таблицу item_props
    def after_update(strsubcat)

      # TODO-0:: проверить, что таблица удаляется, затем создаётся и заполняется, когда добавляем свойства

      if strsubcat.prop_names_changed?
        Rails.logger.debug '[TRACE] <StrsubcatObserver.after_update> Удаляем таблицу, чистим item_props.'
        # byebug
        StrsubcatRuntimeTables.table_drop(strsubcat)
        StrsubcatRuntimeTables.check_and_clean_item_props(strsubcat)
      else
        Rails.logger.debug '[TRACE] <StrsubcatObserver.after_update> Просто обновилась...'
        # byebug
      end

      StrsubcatRuntimeTables.table_check_and_build(strsubcat)

      StrsubcatRuntimeTables.table_fill(strsubcat.id)

    end

    # Админ удаляет подкатегорию:
    #   • удаляем таблицу вещей подкатегории типа str_111_items
    def before_destroy(strsubcat)
      Rails.logger.debug "[TRACE] <StrsubcatObserver.before_destroy> Удалена подкатегория #{strsubcat.id}."
      # byebug
      StrsubcatRuntimeTables.table_drop(strsubcat) # 1)
    end


  end
end