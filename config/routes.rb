BillUp::Application.routes.draw do
  get "organisations/new"

  get "welcome/index"
  get "welcome/terms"




  match "sign_in", :to => "sessions#new", :as => "sign_in"
  match "sign_out", :to => "sessions#destroy", :as => "sign_out"
  match "sign_up", :to => "users#new", :as => "sign_up"
  match "terms", :to => "welcome#terms", :as => "terms"




  resources :organisations
  resources :sessions
  resources :users




  root :to => 'welcome#index'
end
