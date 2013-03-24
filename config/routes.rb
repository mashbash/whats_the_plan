WhatsThePlan::Application.routes.draw do

  devise_for :users
  resources :users, :only => [:show]

  root :to     => 'plans#index'

  post '/yelp' => 'yelp_queries#create'

  resources :plans, :only => [:new, :create, :index, :show]
  
end
