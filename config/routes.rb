Rails.application.routes.draw do
  resources :survivors, only: [:create, :update] do
    resources :infection_reports, only: [:create]
  end
end
