require 'babosa'

class C80Yax::Strsubcat < ActiveRecord::Base

  include C80Yax::Mixins::Strsubcat::Database::Props
  include C80Yax::Mixins::Strsubcat::Database::PropNamesChanged

  validates :title,
            presence: true,
            uniqueness: true,
            length: { in: 6..50 }

  has_and_belongs_to_many :cats
  public_constant :HABTM_Cats

  has_many :subordinates,
           class_name: 'C80Yax::Strsubcat',
           foreign_key: 'parent_id'

  belongs_to :parent,
             class_name: 'C80Yax::Strsubcat'

  has_and_belongs_to_many :prop_names,
                          :after_add => :after_add_prop_names,
                          :after_remove => :after_remove_prop_names
  public_constant :HABTM_PropNames

  has_many :items, :dependent => :destroy

  # <editor-fold desc="# PROPS">
  has_many :main_props, :dependent => :destroy
  accepts_nested_attributes_for :main_props,
                                :reject_if => lambda { |attributes|
                                  !attributes.present?
                                },
                                :allow_destroy => true

  has_many :price_props, :dependent => :destroy
  accepts_nested_attributes_for :price_props,
                                :reject_if => lambda { |attributes|
                                  !attributes.present?
                                },
                                :allow_destroy => true

  has_many :common_props, :dependent => :destroy
  accepts_nested_attributes_for :common_props,
                                :reject_if => lambda { |attributes|
                                  !attributes.present?
                                },
                                :allow_destroy => true

  has_many :prefix_props, :dependent => :destroy
  accepts_nested_attributes_for :prefix_props,
                                :reject_if => lambda { |attributes|
                                  !attributes.present?
                                },
                                :allow_destroy => true

  # </editor-fold>

  extend FriendlyId
  friendly_id :slug_candidates, :use => :slugged

  def slug_candidates
    [:title] + Array.new(6) {|index| [:title, index+2]}
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  scope :menu_order, -> {order(:ord => :asc)}

  # ------------------------------------------------------------------------------------------------------------------------

  ransacker :parent_id,
            formatter: proc { |v|
              # Rails.logger.debug "[TRACE] <v> #{v}"
              results = C80Yax::Strsubcat
                            .where(:parent_id => v)
                            .map(&:id)
              # Rails.logger.debug "[TRACE] <results> #{results}"
              results = results.present? ? results : nil
            }, splat_params: true do |parent|
    parent.table[:id]
  end

end
