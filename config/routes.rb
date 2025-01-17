Rails.application.routes.draw do
  resources :comments
  resources :episodes, :except => [:index] do 
    member do
      put "watch", to: "episodes#watch"
    end
  end
  resources :series, :only => [:index, :show] do
    collection do
      post "add", to: "series#add"
      post "addnouser", to: "series#addnouser"
      post "adduser", to: "series#adduser"
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: redirect(path: "/to-watch")
  get "to-watch", to: "series#index"
  # get "users/:id/profile", to: "profile#show"
  resources :comments
  resources :profile do
    member do
      get "recent", to: "profile#recent"
    end
  end
end
