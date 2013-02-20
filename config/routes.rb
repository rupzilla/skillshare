SkillShare::Application.routes.draw do
  resources :workshops

  resources :subscriptions

  resources :upvotes

  resources :sharers

  resources :learners

    # Semi-static page routes
    match 'home' => 'home#index', :as => :home





    # Set the root url
    root :to => 'home#index'

end







