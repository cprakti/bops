Rails.application.routes.draw do
  root "spa#index"

  resources :records, only: [:index, :create, :update]
  resources :title_words, only: [:index]
  resources :artists, only: [:show]

  match "*path", to: "spa#index", via: :all
end
