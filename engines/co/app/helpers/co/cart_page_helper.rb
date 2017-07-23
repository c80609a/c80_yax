module Co
  module CartPageHelper

    def c80_yax_render_cart(page_content = '')
      render partial: 'co/cart_page',
             locals: {
                 page_content: page_content
             }
    end

    def render_cart_order_form

      render :partial => 'co/cart/shared/cart_order_form',
             :locals => {
                 :mess => "MessageFeedback.new"
             }

    end

    def render_ok_message
      render :partial => "c80_feedback_form/site/shared/ok_message",
             :locals => {
                 ok_text: "Мы свяжемся с Вами в ближайшее время.",
                 wtitle: "Ваше сообщение отправлено"
             }
    end

  end
end