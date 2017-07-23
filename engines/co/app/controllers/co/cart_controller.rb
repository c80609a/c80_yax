module Co
  class CartController < ::ApplicationController

    def give_me_cart_order_form
    end

    def message_cart_order
      # puts "<MessController.handle_message_feedback>"
      # m = MessageFeedback.new(mess_params)
      # respond_to do |format|
      #   if m.save
      #
      #     format.js
      #     MessageFeedbackMailer.send_mess(m, "Сообщение с сайта").deliver
      #   else
      #     puts "<MessController.handle_message_feedback> errors: #{m.errors}"
      #     format.js { render json: m.errors, status: :unprocessable_entity }
      #   end
      # end
    end

    # def mess_params
    #   params.require(:mess).permit(:name, :email_or_phone, :comment, :kapcha)
    # end

  end
end