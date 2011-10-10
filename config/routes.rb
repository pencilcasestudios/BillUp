BillUp::Application.routes.draw do
  get "welcome/index"
  get "welcome/terms"




  match "sign_in", :to => "sessions#new", :as => "sign_in"
  match "sign_out", :to => "sessions#destroy", :as => "sign_out"
  match "sign_up", :to => "users#new", :as => "sign_up"
  match "terms", :to => "welcome#terms", :as => "terms"
  match "user_settings", :to => "users#edit", :as => "user_settings"




  resources :organisations
  resources :sessions
  resources :users




  constraints :subdomain => /.+/ do
    resources :clients
    root :to => 'organisations#show'
  end




  root :to => 'welcome#index'
end
