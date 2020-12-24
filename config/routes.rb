Rails.application.routes.draw do
  resources :survivors, only: [:create, :update], defaults: { format: :json } do
    resources :infection_reports, only: [:create]
    resources :trades, only: [:create]
  end
end
