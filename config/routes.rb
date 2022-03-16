Rails.application.routes.draw do
  get 'pages/about'
  get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "pages#home"

  get "about", to: "pages#about"
end
