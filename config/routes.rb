Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin/console', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :blobs, only: [:index, :show, :update, :destroy] do
    resource :container, only: :show

    get :download, on: :member
  end

  resources :containers, only: [:index, :show] do
    post 'upload/:filename', on: :member, action: :upload

    resources :blobs, param: :filename, only: [:index, :show, :update, :create, :destroy]
  end

  resources :containers, as: :buckets, path: :buckets, param: :'scope/:tag', only: :show

  resources :tags, only: [:show, :index]

  namespace :tagged do
    scope ':tag' do
      get '/', controller: :containers, action: :index
      resource :container, controller: :containers, only: :show
      resources :blobs, only: :index
    end
  end
end
