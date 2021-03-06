Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :communities
  resources :messages
  resources :users do
    get 'friends/', to: "friends#index"
    delete 'friends/:friend_id', to: "friends#destroy"
    resources :friend_requests
    resources :communities
    resources :messages
  end
  post "/login/", to: "users#login" 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
