Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin/console', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  jsonapi_resources :blobs

  jsonapi_resources :containers, only: :show do
    jsonapi_related_resources :blobs, only: :index
    # jsonapi_related_resources :container_blobs,
    #                           only: [:index, :show],
    #                           controller: 'container_blobs',
    #                           path: 'blobs' do
    #   get 'download', on: :member
    # end
  end
end
