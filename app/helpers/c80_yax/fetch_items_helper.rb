module C80Yax
  module FetchItemsHelper

    def render_related(type, thumb_size = 'thumb_md', page=1, per_page = 16)
      # noinspection RubyCaseWithoutElseBlockInspection
      case type
        when 'hit'
          c80_yax_render_offers_hits(thumb_size, page, per_page)
        when 'offers'
          c80_yax_render_offers_index(thumb_size, page, per_page)
      end
    end

  end
end