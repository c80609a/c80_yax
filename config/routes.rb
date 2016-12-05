C80Yax::Engine.routes.draw do
  match 'admin_data_get_strsubcat_propnames', :to => 'admin_data#get_strsubcat_propnames', :via => :post
end
