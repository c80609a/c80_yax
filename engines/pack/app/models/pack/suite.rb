module Pack
  class Suite < ActiveRecord::Base

    validates :title,
              :presence => true,
              :length => { in: 2..255 }
    
  end
end