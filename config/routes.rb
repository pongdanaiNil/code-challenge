Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      devise_for :users, skip: :all
      resources :users, only: [] do
        collection do
          post :registration
        end
      end
      resources :keywords, only: %i[index show update destroy] do
        collection do
          post :upload
        end
      end
    end
  end
end
