module Of
  module OffersListHelper

    # Выдать html unordered list Акций
    #
    def render_ul_offers_list(&make_offer_url)

      p_make_offer_url = Proc.new &make_offer_url
      offers = Offer.all

      render :partial => 'of/offers_list',
             :locals => {
                 offers: offers,
                 p_make_offer_url: p_make_offer_url
             }

    end

  end
end