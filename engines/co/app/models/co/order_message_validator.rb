module Co
  class OrderMessageValidator < ActiveModel::Validator
    def validate(record)
      unless record.errors.present?
        puts "<OrderMessageValidator.validate> record = #{record}"

        unless record.name.present?
          record.errors[:name] = 'Укажите, пожалуйста, Ваше имя'
        end

        if record.phone.present?
          if record.phone[/^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$/].present?
            t2 = 'Пожалуйста, укажите корректный номер телефона'
            record.errors[:phone] = t2
          end
        end

      end

    end
  end
end