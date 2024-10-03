Rails.application.routes.draw do
  namespace :admin do
    get 'comments/index'
    get 'comments/update'
  end
  get 'comments/create'
  get 'books/index'
  get 'books/show'
  get 'books/new'
  get 'books/create'
  get 'books/edit'
  get 'books/update'
  get 'books/destroy'
  get 'posts/index'
  get 'posts/show'
  get 'posts/new'
  get 'posts/create'
  get 'posts/edit'
  get 'posts/update'
  get 'posts/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  Rails.application.routes.draw do
    root 'posts#index'

    resources :posts

    resources :books do
      resources :comments, only: [:create]
    end

    namespace :admin do
      resources :comments, only: %i[index update]
    end
  end
end
