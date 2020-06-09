Rails.application.routes.draw do
  devise_for :admins
  devise_for :clients
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/products', to: 'products#index'
  get '/showcart', to: 'cart#showcart'
  post '/addprod', to: 'cart#addprod'
end
