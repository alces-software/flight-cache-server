Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin/console', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :blobs, only: :show do
    resource :container, only: :show

    get :download, on: :member
  end

  resources :containers, only: :show do
    post 'upload/:filename', on: :member, action: :upload

    resources :blobs, only: :index
  end

  namespace :tag, path: :tags do
    scope ':tag', controller: :containers do
      get '/', action: :index
      get '/user', action: :show
      get '/group', action: :show_group

      resources :blobs, only: :index
    end
  end
end
