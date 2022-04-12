Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "submission#index"
  get '/sift', to: 'sift#index'
  get '/submissions/new', to: 'submission#new'
  post '/submissions/new', to: 'submission#create'
  get '/about-us', to: 'submission#about-us'
end
