C80Yax::Engine.routes.draw do
  match 'admin_data_get_strsubcat_propnames', :to => 'admin_data#get_strsubcat_propnames', :via => :post
  mount Pack::Engine => '/'
  mount Co::Engine => '/'
  match 'fetch_items', to: 'ajax#fetch_items', via: :get
end
