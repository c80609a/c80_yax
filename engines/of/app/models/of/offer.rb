module Of
  class Offer < ActiveRecord::Base
    has_many :ophotos, :dependent => :destroy
    accepts_nested_attributes_for :ophotos,
                                  :reject_if => lambda { |attributes|
                                    !attributes.present?
                                  },
                                  :allow_destroy => true
    has_and_belongs_to_many :items,
                       class_name: 'C80Yax::Item',
                       foreign_key: 'item_id',
                       join_table: 'of_items_offers',
                       association_foreign_key: 'offer_id'

    # validates_with DocValidator
    default_scope {order(:created_at => :desc)}

    def cover_url(thumb_size='thumb_md')
      res = ''
      unless ophotos.size.zero?
        res = ophotos.first.image.send(thumb_size).url
      end
      res
    end

  end
end