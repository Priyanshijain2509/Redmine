Rails.application.routes.draw do
  root 'static_pages#index'

  get 'users/:user_id/projects/:project_id/activity', to: 'projects#activity', as: :project_activity
  get 'users/:user_id/projects/:project_id/roadmap', to: 'projects#roadmap', as: :project_roadmap
  get 'users/:user_id/projects/:project_id/overview', to: 'projects#overview', as: :project_overview
  get 'projects/overview', to: 'projects#overview', as: :overview
  get 'issues/my_page', to: 'issues#my_page', as: :issues_my_page
  get 'issues/reported_issue', to: 'issues#reported_issue'
  get 'static_pages/download', to: 'static_pages#download'
  get 'static_pages/home'
  get 'static_pages/help'
  get '/signup', to: 'users#new'

  devise_for :users

  resources :users do
    resources :projects do
      collection do
        get :search
      end
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