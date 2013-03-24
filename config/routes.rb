WhatsThePlan::Application.routes.draw do

  devise_for :users
  resources :users, :only => [:show]

  root :to => 'plans#index'

  resources :plans, :only => [:new, :create, :index, :show]
  
end
