module Of
  module OfferShowHelper

    def render_show_offer(offer)

      render :partial => 'of/offer',
             :locals => {
                 offer: offer.decorate
             }

    end

  end
end