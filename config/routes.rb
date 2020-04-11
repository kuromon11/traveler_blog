Rails.application.routes.draw do
  #Twitterログイン可
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations'
  }


  root to: 'posts#index'
  resources :posts do
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
    collection do
      get 'search'
      get 'ranking'
      get 'prefectures'
    end
  end
  resources :users, only: :show
end
