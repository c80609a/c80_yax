module Ti
  class DocValidator < ActiveModel::Validator
    def validate(record)

      unless record.title.present?
        record.errors[:title] = 'Название не может быть пустым'
      end

    end
  end
end