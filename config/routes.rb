Rails.application.routes.draw do
  scope module: :web do
    root to: 'posts#index'

    resources :posts do
      scope module: :posts do
        resources :comments
      end
    end

    resources :users, only: [:new, :create]

    namespace :user do
      resource :session, only: [:new, :create, :destroy]
    end
  end
end
