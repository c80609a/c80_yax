
# Код, находящийся здесь, добавляет модели Strsubcat метод prop_names_changed?
# Для habtm свойств нельзя вызвать `.._changed?` метод, по-этому появились эти строки.

module C80Yax
  module Mixins
    module Strsubcat
      module Database
        module PropNamesChanged

          # • этот метод дёргает только StrsubcatSweeper
          # • после вызова метода - значение сбрасывается в false
          def prop_names_changed?
            res = @mark_prop_names_changed
            @mark_prop_names_changed = false
            Rails.logger.debug "[TRACE] <Strsubcat.prop_names_changed?> res = #{res}"
            res
          end

          # Пригодится при удалении из таблицы item_props те строки,
          # чьи имена свойств были удалены из подкатегории.
          def get_list_removed_props
            @list_removed_props = [] unless @list_removed_props.present?
            res = @list_removed_props
            @list_removed_props = []
            Rails.logger.debug "[TRACE] <Strsubcat.get_list_removed_props> res = #{res}"
            res
          end

          private

          # • Два метода after_add_prop_names и after_remove_prop_names
          # слушают изменения prop_names, и, при их наличии,
          # выставляют флаг mark_prop_names_changed в true.
          # • Этот флаг вертает обратно в false
          # метод after_update "чистильщика" StrsubcatSweeper.

          def after_add_prop_names(prop_name)
            unless new_record?
              Rails.logger.debug "[TRACE] <Strsubcat.after_add_prop_names> prop_name.title = #{prop_name.title}"
              @mark_prop_names_changed = true
            end
          end

          def after_remove_prop_names(prop_name)
            Rails.logger.debug "[TRACE] <Strsubcat.after_remove_prop_names> prop_name.title = #{prop_name.title}"
            @mark_prop_names_changed = true
            @list_removed_props = [] unless @list_removed_props.present?
            @list_removed_props << prop_name.id
          end

        end
      end
    end
  end
end