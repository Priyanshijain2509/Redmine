Rails.application.routes.draw do
  root 'static_pages#index'

  devise_for :users
  get 'static_pages/home'
  get 'static_pages/help'

  get '/my/account', to: 'users#show'
  get '/signup', to: 'users#new'

end
