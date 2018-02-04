Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users do
    member do
      get :followings
      get :followers
    end
    collection do
      get :search
    end
  end
  
  resources :posts, only: [:index, :create, :destroy, :show] , shallow: true do 
    resources :post_comments, only: [:index, :create, :destroy]
  end
  
  resources :relationships, only: [:create, :destroy]
  get 'signup', to: 'users#new'
end