module C80Yax
  class AppController < ActionController::Base
    protect_from_forgery with: :exception
    before_filter :authenticate_admin_user!
  end
end