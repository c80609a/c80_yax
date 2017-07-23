module Co
  class MessageOrderMailer < ActionMailer::Base

    default from: Proc.new { SiteProp.first.mail_from },
            to: Proc.new { SiteProp.first.mail_to }

    def send_mess(message, subject)
      @message = format_message(message)

      puts "<MessageOrderMailer.send_mess> Отправляем сообщение."
      mail(subject: subject) do |format|
        format.html { render "mail_mess" }
      end

      #puts "#{SiteProps.first.mail_to}"
    end

    private

    def format_message(message)
      result = "<br> • Имя: #{message.name}"
      result += "<br> • Телефон: #{message.email_or_phone}"
      result += "<br> • Детали заказа: #{message.comment}"
      result
    end

  end
end
