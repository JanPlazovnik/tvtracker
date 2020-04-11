Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: redirect(path: "/to-watch")
  get "to-watch", to: "to_watch#show"
  get "user/:id/profile", to: "profile#show"
end
