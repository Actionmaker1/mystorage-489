Rails.application.routes.draw do
  resources :spaces
  devise_for :users
  root to: 'pages#home'
  resources  :storage
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
