module Ti
  class Category < ActiveRecord::Base
    has_many :child_categories,
             class_name: 'Ti::Category',
             foreign_key: 'parent_category_id',
             dependent: :nullify
    belongs_to :parent_category, class_name: 'Ti::Category'
    has_and_belongs_to_many :docs
    validates :title, presence: true
    scope :listed, -> { where(is_listed: true) }
    default_scope {order(:ord => :asc)}
  end
end