Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :books, only: [:index, :create, :destroy]
      
      resources :borrowings, only: [] do
        collection do
          post :checkout
          patch :return
        end
      end
    end
  end
end
