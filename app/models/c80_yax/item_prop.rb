module C80Yax
  class ItemProp < ActiveRecord::Base
    belongs_to :item
    belongs_to :prop_name

    before_save :before_save_format_value

    private

    def self.capz
      [24, # страна
       36, # бренд
       46] # бренд (старый)
    end

    def self.uppz
      [26, # коэф-т теплопроводности
       27, # морозостойкость
       38, # формат
       80, # Марка прочности кирпича (дубликат, созданный заказчиком)
       75] # марка прочности
    end

    def self.do_not_touch
      [
          78, # Завод производитель
      ]
    end

    def self.siz
      [23] # размер
    end

    def before_save_format_value

      v = self.value
      uom = prop_name.uom

      # удаляем пробелы в начале и в конце строки
      v = v.strip! || v

      # числовые значения преобразуем в числа
      if uom.present? && uom.is_number

        v = v.gsub(' ', '')
        v = v.gsub(',', '.')
        v = v[/([0-9.]+)/]

        # нечисловые значения: либо capitalize, либо upcase, либо downcase
      else

        if prop_name_id.in?(ItemProp.capz)
          v = v.mb_chars.capitalize.to_s
        elsif prop_name_id.in?(ItemProp.uppz)
          v = v.mb_chars.upcase.to_s
        elsif prop_name_id.in?(ItemProp.do_not_touch)
          v = v
        else
          v = v.mb_chars.downcase.to_s
        end

      end

      if prop_name_id.in?(ItemProp.siz)
        v = v.gsub(',', '.')
        sizes = v.scan(/([0-9,]+)/)
        oum = v.scan(/[мс]*м/)
        v = sizes.join(" x ")
        if oum.count > 0
          v += " #{oum[0]}"
        else
          v += ' мм'
        end
      end


      self.value = v

    end

  end

end