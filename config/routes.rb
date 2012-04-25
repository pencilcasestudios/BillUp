BillUp::Application.routes.draw do
  match "account_settings", to: "users#edit", as: "account_settings"
  match "exception_test", to: "welcome#exception_test", as: "exception_test"
  match "pricing", to: "welcome#pricing", as: "pricing"
  match "sign_in", to: "sessions#new", as: "sign_in"
  match "sign_out", to: "sessions#destroy", as: "sign_out"
  match "sign_up", to: "users#new", as: "sign_up"
  match "terms", to: "welcome#terms", as: "terms"
  match "tour", to: "welcome#tour", as: "tour"




  resources :organisations
  resources :sessions
  resources :users




  constraints subdomain: /.+/ do
    resources :clients
    resources :invoices do
      collection do
        get :paid
        get :unpaid
      end
    end
    resources :receipts
    root to: "organisations#show"
  end




  root to: "welcome#index"
end
