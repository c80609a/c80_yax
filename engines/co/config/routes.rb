Co::Engine.routes.draw do
  match '/message_cart_order', :to => 'cart#message_cart_order', :via => :post
  match '/give_me_cart_order_form', :to => 'cart#give_me_cart_order_form', :via => :get
end