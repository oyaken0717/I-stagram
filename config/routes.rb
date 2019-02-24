Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create, :show, :edit]


  resources :feeds do
    collection do
      post:confirm
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
