module Co
  class OrderMessage < ActiveRecord::Base
    validates_with OrderMessageValidator
  end
end
