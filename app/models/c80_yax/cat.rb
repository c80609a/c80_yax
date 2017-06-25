require 'babosa'

module C80Yax
  class Cat < ActiveRecord::Base

    validates :title,
              presence: true,
              uniqueness: true,
              length: { in: 6..50 }

    has_and_belongs_to_many :strsubcats
    mount_uploader :image, IcatUploader

    extend FriendlyId
    friendly_id :slug_candidates, :use => :slugged

    def slug_candidates
      [:title] + Array.new(6) {|index| [:title, index+2]}
    end

    def normalize_friendly_id(input)
      input.to_s.to_slug.normalize(transliterations: :russian).to_s
    end

    scope :menu_order, -> {order(:ord => :asc)}

  end

end