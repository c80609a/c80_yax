module Of
  class Ophoto < ActiveRecord::Base
    belongs_to :offer
    mount_uploader :image, OphotoUploader
  end
end