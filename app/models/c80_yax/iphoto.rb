module C80Yax
  class Iphoto < ActiveRecord::Base
    belongs_to :item
    mount_uploader :image, IphotoUploader
  end

end