Rails.application.routes.draw do
  get 'wikis/index'
  get 'wikis/new'
  get 'wikis/edit'

  root 'static_pages#index'

  devise_for :users
  get 'static_pages/home'
  get 'static_pages/help'

  get '/signup', to: 'users#new'
  get 'users/:id', to: 'users#show', as: :my_account
  resources :users do
    resources :projects do
      resources :wikis
    end
  end
end