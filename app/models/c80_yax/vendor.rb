module C80Yax
  class Vendor < ActiveRecord::Base

    has_and_belongs_to_many :items

    before_save :before_save_format_title

    private

    def before_save_format_title
      self.title = self.title.mb_chars.capitalize.to_s unless self.as_is
    end

  end

end