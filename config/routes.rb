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
      resources :blobs, only: :index, defaults: { list_all_tagged_blobs: true }

      scope :user, controller: :containers do
        get '/', action: :show

        resources :blobs, only: :index
      end

      scope :group, controller: :containers, defaults: { group: :true } do
        get '/', action: :show

        resources :blobs, only: :index
      end

      scope :public, controller: :containers, defaults: { group: 'public' } do
        get '/', action: :show

        resources :blobs, only: :index
      end
    end
  end
end
