Rails.application.routes.draw do
  get 'edit_issues/index'
  get 'edit_issues/create'
  get 'edit_issues/edit'
  get 'edit_issues/update'
  get 'edit_issues/delete'
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
      resources :issues do
        resources :edit_issues
      end
    end
  end

end