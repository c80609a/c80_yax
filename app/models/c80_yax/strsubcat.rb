require "babosa"

class C80Yax::Strsubcat < ActiveRecord::Base

  has_many :subordinates,
           class_name: 'C80Yax::Strsubcat',
           foreign_key: 'parent_id'

  belongs_to :parent,
             class_name: 'C80Yax::Strsubcat'

  # has_many :items, :dependent => :destroy

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
