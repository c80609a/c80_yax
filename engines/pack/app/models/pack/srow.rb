module Pack
  class Srow < ActiveRecord::Base
    belongs_to :suite
    belongs_to :item, class_name: 'C80Yax::Item'
    scope :def_order, -> {order(:ord => :asc)}

  end
end