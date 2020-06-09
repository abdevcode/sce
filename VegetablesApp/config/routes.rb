Rails.application.routes.draw do
  devise_for :admins
  devise_for :clients, skip: [:registrations]
  as :client do
    get '/clients', to: 'clients#index'
    get "/clients/sign_in", to: "devise/sessions#new" # custom path to login/sign_in
    get "/clients/new", to: "clients#new", as: "new_client_registration" # custom path to sign_up/registration
    get '/clients/:id/', to: 'clients#show', :as => 'client'
    get '/clients/:id/edit', to: 'clients#edit', :as => 'edit_client'
    post '/clients', to: 'clients#create'
    put '/clients/:id/', to: 'clients#update'
    patch '/clients/:id/', to: 'clients#update'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  get '/products/:id/edit', to: 'products#edit', as: 'up_product'
  get '/products/:id', to: 'products#show', as: 'product'
  get '/products/new', to: 'products#new'
  get '/products', to: 'products#index'
  post '/products', to: 'products#create'
  put '/products/:id/', to: 'products#update'
  patch '/products/:id/', to: 'products#update'
  delete '/products/:id/', to: 'products#delete'

  get '/categories/:id/edit', to: 'categories#edit', as: 'up_category'
  get '/categories/:id', to: 'categories#show', as: 'category'
  get '/categories/new', to: 'categories#new'
  get '/categories', to: 'categories#index'
  post '/categories', to: 'categories#create'
  put '/categories/:id/', to: 'categories#update'
  patch '/categories/:id/', to: 'categories#update'
  delete '/categories/:id/', to: 'categories#delete'

  get '/showcart', to: 'cart#showcart'
  post '/addprod', to: 'cart#addprod'

end
