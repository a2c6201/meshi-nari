Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i(index show create destroy) do
        resources :menus, only: %i(index create)
      end
    end
  end
end
