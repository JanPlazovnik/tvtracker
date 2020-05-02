Rails.application.routes.draw do
  resources :episodes, :except => [:index] do 
    member do
      put "done", to: "series#done"
    end
  end
  resources :series, :only => [:index, :show] do
    collection do
      post "add", to: "series#add"
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: redirect(path: "/to-watch")
  get "to-watch", to: "series#index"
  # get "users/:id/profile", to: "profile#show"
  resources :profile
end
