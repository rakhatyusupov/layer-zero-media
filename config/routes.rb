Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "articles#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "devise/sessions#new", as: :unauthenticated_root
  end

  resources :articles do
    resources :comments, only: [:create, :destroy]
  end
end
