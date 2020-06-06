Rails.application.routes.draw do
  devise_for :admins
  devise_for :clients
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/products', to: 'products#index'
  get '/products/new', to: 'products#new'
  get '/products/:id', to: 'products#show', as: 'product'
  post '/products', to: 'products#create'
  get '/products/:id/edit', to: 'products#edit', as: 'up_product'
  put '/products/:id/', to: 'products#update'
  patch '/products/:id/', to: 'products#update'
  delete '/products/:id/', to: 'products#delete'
end
