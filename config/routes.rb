# frozen_string_literal: true

Rails.application.routes.draw do
  resources :survivors, only: %i[create update], defaults: { format: :json } do
    resources :infection_reports, only: [:create]
    resources :trades, only: [:create]
  end
end
