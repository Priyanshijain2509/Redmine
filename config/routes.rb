Rails.application.routes.draw do
  root 'static_pages#index'

  get 'users/:user_id/projects/:project_id/activity', to: 'projects#activity',
    as: :project_activity
  get 'users/:user_id/projects/:project_id/roadmap', to: 'projects#roadmap',
    as: :project_roadmap
  get 'users/:user_id/projects/:project_id/overview', to: 'projects#overview',
    as: :project_overview

  get 'projects/overview', to: 'projects#overview', as: :overview
  delete 'projects/:id/remove_assigned_user', to:
    'projects#remove_assigned_user', as: :remove_assigned_user

  get 'issues/my_page', to: 'issues#my_page', as: :issues_my_page
  get 'issues/reported_issue', to: 'issues#reported_issue'
  delete '/users/:user_id/projects/:project_id/issues/:id/remove',
    to: 'issues#remove_label', as: :remove_label
  patch '/users/:user_id/projects/:project_id/issues/:id/label',
    to: 'issues#add_label', as: :add_label
  patch '/users/:user_id/projects/:project_id/issues/:id/resolved',
    to: 'issues#resolved', as: :issue_resolved

  get '/fetch_issue_data/:edit_issue_id', to: 'edit_issues#fetch_issue_data'

  post 'notifications/mark_as_read', to: 'notifications#mark_as_read'
  get 'notifications/unread_count', to: 'notifications#unread_count'
  
  get 'static_pages/download', to: 'static_pages#download'
  get 'static_pages/home'
  get 'static_pages/help'
  get '/signup', to: 'users#new'

  devise_for :users

  resources :users do
    resources :projects do
      collection do
        get :search
        get '/:project_id/search_email', action: :search_email, as: :search_email
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
  resources :notifications
end