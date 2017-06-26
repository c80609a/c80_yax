module Pack
  class Suite < ActiveRecord::Base

    has_many :srows, :dependent => :destroy
    accepts_nested_attributes_for :srows,
                                  :reject_if => lambda { |attributes|
                                    !attributes.present?
                                  },
                                  :allow_destroy => true    
    
    validates :title,
              :presence => true,
              :length => { in: 2..255 }
    
  end
end