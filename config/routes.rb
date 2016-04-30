Rails.application.routes.draw do
  scope module: :web do
    root to: 'posts#index'
  end
end
