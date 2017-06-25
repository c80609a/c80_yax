module C80Yax
  class Color < ActiveRecord::Base

    validates :title,
              presence: true,
              uniqueness: true,
              length: { in: 2..50 }

    validates :value,
              presence: true,
              uniqueness: true,
              length: { in: 2..50 }

    validates :skidka,
              length: { in: 3..250 }

    has_and_belongs_to_many :items

  end

end