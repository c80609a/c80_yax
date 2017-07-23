module Co
  class CartController < ::ApplicationController

    def give_me_cart_order_form
    end

    def message_cart_order
      puts '<CartController.message_cart_order>'
      m = OrderMessage.new(mess_params)
      respond_to do |format|
        if m.save

          format.js
          OrderMessageMailer.send_mess(m, 'Заказ').deliver
        else
          puts "<CartController.message_cart_order> errors: #{m.errors}"
          format.js { render json: m.errors, status: :unprocessable_entity }
        end
      end
    end

    def mess_params
      params.require(:mess).permit(:name, :phone, :comment, :city)
    end

  end
end