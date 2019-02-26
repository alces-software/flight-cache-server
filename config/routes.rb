Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin/console', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  jsonapi_resources :blobs, only: :show do
    get :download, on: :member
  end

  jsonapi_resources :containers, only: :show do
    jsonapi_related_resources :blobs, only: :index
  end
end
