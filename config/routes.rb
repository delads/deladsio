Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # defaults to dashboard
  # root :to => redirect('/dashboard')

  get 'welcome/index'
 
  root 'welcome#index'
  
  # view routes
  resources :sensors
  resources :makers, except: [:new] 
  resources :map
  resources :charts
  resources  :triggers

  
  get '/dashboard' => 'dashboard#index'
  get '/triggers' => 'triggers#index'

  get '/login', to: "logins#new"
  post '/login', to: "logins#create"
  get '/logout', to: "logins#destroy"

  get '/register', to: 'makers#new'
  get '/sensors/:id/destroy', to: 'sensors#destroy'
  get '/triggers/:id/destroy', to: 'triggers#destroy'

  get '/makers/:id/destroy', to: 'makers#destroy'

  
  # api routes
  get '/api/i18n/:locale' => 'api#i18n'
  get '/api/setsensorpropertyvalue' => "apis#setsensorpropertyvalue"
  get '/api/setsigfoxsensorvalue' => "apis#setsigfoxsensorvalue"
  get '/api/createtimeseries' => "apis#createtimeseries"

end
