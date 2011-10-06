BillUp::Application.routes.draw do
  get "welcome/index"
  get "welcome/terms"




  match "sign_in", :to => "sessions#new", :as => "sign_in"
  match "sign_out", :to => "sessions#destroy", :as => "sign_out"
  match "sign_up", :to => "users#new", :as => "sign_up"
  match "terms", :to => "welcome#terms", :as => "terms"
  match "user_settings", :to => "users#edit", :as => "user_settings"




  resources :sessions
  resources :users
  resources :organisations




  constraints :subdomain => /.+/ do
    root :to => 'organisations#show'
  end
  root :to => 'welcome#index'
end
