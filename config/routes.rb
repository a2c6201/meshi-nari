Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :users, only: %i(index show create destroy) do
        resources :menus, only: %i(index create)
      end
    end
  end
end
