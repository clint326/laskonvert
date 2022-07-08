Rails.application.routes.draw do
  resources :process, only: [:destroy] do
    resources :step, only: [:new, :create]
  end
  root "home#index"
end
