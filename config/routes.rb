Flog::Application.routes.draw do
  
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => "posts#index", :page => '1'

  resource :comments
  
  # posts by page
  match '/page(/:page)' => "posts#index",
    :page => /\d{1,}/, 
    :defaults => {:page => '1'}
    
  # posts by date
  match '/:year(/:month(/:day))(/page/:page)' => "posts#index",
    :year => /\d{4}/, 
    :month => /\d{1,2}/,
    :day => /\d{1,2}/,
    :page => /\d{1,}/, 
    :defaults => {:page => '1'}  
    
   # posts by tag
  match '/tag/:tag(/page/:page)' => "posts#index",
    :tag => /[\w-]+/, 
    :page => /\d{1,}/, 
    :defaults => {:page => '1'}
    
  match '/:slug' => "posts#show", :as => :post

end
