Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i(index show create destroy)
      resources :menus, only: %i(create)
    end
  end
end
