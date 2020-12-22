Rails.application.routes.draw do
  resources :survivors, only: [:create]
end
