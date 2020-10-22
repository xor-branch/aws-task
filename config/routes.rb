Rails.application.routes.draw do
  devise_for :users
  root 'blogs#index'
  get 'comments/create'

  resources :blogs do
    resources :comments
  end
  mount LetterOpenerWeb::Engine, at: "/inbox" if Rails.env.development?
end
