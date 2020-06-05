Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'users/sessions'}


  get '/404', :to => "errors#not_found"
  get '/422', :to => "errors#unacceptable"
  #get '/500', :to => "errors#server_error"  

  get '/about', :to => "pages#about"


  resources :properties

  get '/select_property' => "properties#select"
  
  # Authenticated route to show Dashboard as root when used signed
  authenticated :user do 
  	root to: 'pages#dashboard', as: "authenticated_user" 
  end

  root to: 'pages#home'


end
