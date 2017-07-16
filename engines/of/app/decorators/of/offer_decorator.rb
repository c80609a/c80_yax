module Of
  class OfferDecorator < ::ApplicationDecorator
    decorates 'Of::Offer'
    delegate_all

    def items_list(thumb_size = 'thumb_md', page=1, per_page = 16)
      its = model.items
                .includes(item_props: {prop_name: [:uom, :related]})
                .includes(:iphotos)
                .includes(:strsubcat)
                .paginate(page: page, per_page: per_page)
      items = C80Yax::ItemDecorator.decorate_collection(its)

      h.render partial: 'c80_yax/items/index',
             locals: {
                 items: items,
                 without_paginator: false,
                 will_paginate_items: its,
                 thumb_size: thumb_size
             }
    end

  end
end