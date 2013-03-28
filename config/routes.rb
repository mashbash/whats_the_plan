WhatsThePlan::Application.routes.draw do
  devise_for :users
  resources :users, :only => [:show]
  resources :plans, :only => [:new, :create, :index, :show]
  root :to     => 'plans#index'
  post '/yelp' => 'yelp_queries#create'
  get 'plans/:id/refresh' => 'plans#refresh'
  match '*path' => 'not_found#show'
end
