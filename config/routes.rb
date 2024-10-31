Rails.application.routes.draw do
  devise_for :users
  # devise_for :users
  root 'books#index'

  resources :posts # Esto genera todas las rutas CRUD para posts

  resources :books do
    resources :comments, only: [:create] # Rutas anidadas para comentarios de libros
  end

  namespace :admin do
    resources :comments, only: %i[index update] # Rutas del admin para comentarios
  end

  # Ruta de health check
  get 'up' => 'rails/health#show', as: :rails_health_check
end
