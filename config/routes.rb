Rails.application.routes.draw do
  root to: "ideas#index"
  
  # Ideas and reviews routes
  resources :ideas do
    resources :reviews, only: [:create, :destroy], shallow: true
  end

  # User routes
  resources :users, only: [:new, :create]

  # Session routes
  resource :session, only: [:new, :create, :destroy]
end
