require 'babosa'
include ActionView::Helpers::SanitizeHelper

module Ti
  class Doc < ActiveRecord::Base
    has_many :dphotos, :dependent => :destroy
    accepts_nested_attributes_for :dphotos,
                                  :reject_if => lambda { |attributes|
                                    !attributes.present?
                                  },
                                  :allow_destroy => true
    has_and_belongs_to_many :categories
    validates_with DocValidator
    default_scope {order(:created_at => :desc)}

    extend FriendlyId
    friendly_id :title, use: :slugged
    def normalize_friendly_id(input)
      input.to_s.to_slug.normalize(transliterations: :russian).to_s
    end

    def slug_candidates
      [:title] + Array.new(6) {|index| [:title, index+2]}
    end

    def short_meta_description

      if description.present? && description.length > 200
        result = description
      elsif full.present? && full.length > 0
        result = strip_tags(full[0..200]+'...')
      else
        result = nil
      end
      result

    end

    def thumb_sm
      s = ''
      if dphotos.count > 0
        s = dphotos.first.image.thumb_sm
      end
      s
    end
    
    def thumb_md
      s = ''
      if dphotos.count > 0
        s = dphotos.first.image.thumb_md
      end
      s
    end
    
    def thumb_lg
      s = ''
      if dphotos.count > 0
        s = dphotos.first.image.thumb_lg
      end
      s
    end
    
    def thumb_preview
      s = ''
      if dphotos.count > 0
        s = dphotos.first.image.thumb_preview
      end
      s
    end

  end
end