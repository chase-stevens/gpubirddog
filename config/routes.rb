Rails.application.routes.draw do
  root "gpus#index"

  get "/price_index", to: "gpus#price_index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
