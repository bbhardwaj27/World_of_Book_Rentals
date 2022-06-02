Rails.application.routes.draw do
  resources :books, only: [:index, :show] do
    resources :reviews, only: [:index, :show]
  end

  devise_for :users
  root to: 'pages#home'
end
