Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin/console', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  jsonapi_resources :blobs, only: :show do
    jsonapi_links :container, only: :show
    jsonapi_related_resource :container, only: :show
    get :download, on: :member
  end

  jsonapi_resources :containers, only: :show do
    jsonapi_links :blobs, only: :show
    jsonapi_related_resources :blobs
    # jsonapi_resources :blobs, only: :create, reflect: true
  end
end
