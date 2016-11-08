require 'babosa'

class C80Yax::Item < ActiveRecord::Base

  validates :title,
            presence: true,
            uniqueness: true,
            length: { in: 6..150 }

  validates :strsubcat,
            presence: true

  # has_and_belongs_to_many :vendors
  belongs_to :strsubcat

  has_many :iphotos, :dependent => :destroy
  accepts_nested_attributes_for :iphotos,
                                :reject_if => lambda { |attributes|
                                  !attributes.present?
                                },
                                :allow_destroy => true  
  
=begin
  has_many :item_props, :dependent => :destroy
  accepts_nested_attributes_for :item_props,
                                :reject_if => lambda { |attributes|
                                  # puts "attributes:: #{attributes}"
                                  # attributes:: {"value"=>"", "prop_name_id"=>""}
                                  !attributes.present? || \
                                  !attributes[:value].present? || \
                                  !attributes[:prop_name_id].present?
                                },
                                :allow_destroy => true

=end

  has_many :related_childs, :class_name => 'C80Yax::Item', :foreign_key => 'related_parent_id'
  belongs_to :related_parent, :class_name => 'C80Yax::Item'

  extend FriendlyId
  friendly_id :slug_candidates, :use => :slugged

  def slug_candidates
    [:title] + Array.new(6) {|index| [:title, index+2]}
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

end
