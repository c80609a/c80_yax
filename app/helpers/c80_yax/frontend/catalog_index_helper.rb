module C80Yax
  module Frontend
    module CatalogIndexHelper

      def c80_yax_render_catalog_index(thumb_size = 'thumb_md', page=1, per_page = 16)
        itms = C80Yax::Item.includes(item_props: {prop_name: [:uom, :related]})
                   .includes(:iphotos)
                   .includes(:strsubcat)
                   .paginate(page: page, per_page: per_page)
        items = ItemDecorator.decorate_collection(itms)
        render partial: 'c80_yax/items/index',
               locals: {
                   items: items,
                   without_paginator: false,
                   will_paginate_items: itms,
                   thumb_size: thumb_size
               }
      end

      def c80_yax_render_related(item, thumb_size = 'thumb_md', count = 4)
        itms = C80Yax::Item.includes(item_props: {prop_name: [:uom, :related]})
                   .includes(:iphotos)
                   .includes(:strsubcat)
                   .where(c80_yax_items: { strsubcat_id: item.strsubcat.id })
                   .limit(count)
        items = ItemDecorator.decorate_collection(itms)
        render partial: 'c80_yax/items/index',
               locals: {
                   items: items,
                   without_paginator: true,
                   thumb_size: thumb_size
               }
      end

      def c80_yax_render_similar(item, thumb_size = 'thumb_md', count = 4)
        itms = item.similar_items
                   .includes(item_props: {prop_name: [:uom, :related]})
                   .includes(:iphotos)
                   .includes(:strsubcat)
                   .limit(count)
        items = ItemDecorator.decorate_collection(itms)
        render partial: 'c80_yax/items/index',
               locals: {
                   items: items,
                   without_paginator: true,
                   thumb_size: thumb_size
               }
      end

      def c80_yax_render_offers_index(thumb_size = 'thumb_md', page=1, per_page = 16)
        itms = Item.joins(:offers)
                   .includes(item_props: {prop_name: [:uom, :related]})
                   .includes(:iphotos)
                   .includes(:strsubcat)
                   .paginate(page: page, per_page: per_page)
        items = ItemDecorator.decorate_collection(itms)
        render partial: 'c80_yax/items/index',
               locals: {
                   items: items,
                   without_paginator: true,
                   thumb_size: thumb_size
               }
      end

      def c80_yax_render_offers_hits(thumb_size = 'thumb_md', page=1, per_page = 16)
        itms = Item.where(is_hit: true)
                   .includes(item_props: {prop_name: [:uom, :related]})
                   .includes(:iphotos)
                   .includes(:strsubcat)
                   .paginate(page: page, per_page: per_page)
        items = ItemDecorator.decorate_collection(itms)
        render partial: 'c80_yax/items/index',
               locals: {
                   items: items,
                   without_paginator: true,
                   thumb_size: thumb_size
               }
      end

      private

    end
  end
end