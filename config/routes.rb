Rails.application.routes.draw do
  get 'comments/index'
  get 'comments/new'
  root 'static_pages#index'

  devise_for :users
  get 'static_pages/home'
  get 'static_pages/help'

  get '/signup', to: 'users#new'
  get 'users/:id', to: 'users#show', as: :my_account

  resources :users do
    resources :projects do
      resources :wikis
      resources :news do
        resources :comments
      end
    end
  end

end