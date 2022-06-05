Rails.application.routes.draw do
  resources :books do
    resources :reviews, only: [:index, :show, :create, :destroy, :review]

  end
  resources :reviews do
    resources :reviews, only: [:index, :show, :create, :destroy, :review]
  end
  devise_for :users
  root to: 'pages#home'
end
