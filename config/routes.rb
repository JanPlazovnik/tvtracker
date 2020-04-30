Rails.application.routes.draw do
  resources :episodes
  resources :series, :only => [:index] do
    collection do
      post "add", to: "series#add"
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: redirect(path: "/to-watch")
  get "to-watch", to: "series#index"
  get "user/:id/profile", to: "profile#show"
end
