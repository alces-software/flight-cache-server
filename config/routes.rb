Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin/console', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :blobs, only: :show

  resources :containers, only: :show do
    resources :blobs, only: :index do
      post 'upload/:filename', on: :collection, action: :upload
    end
  end
end
