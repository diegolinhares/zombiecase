# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, constraints: { subdomain: 'api' }, path: '/' do
    resources :survivors, only: %i[create update] do
      resources :infection_reports, only: [:create]
      resources :trades, only: [:create]
    end

    resources :reports, only: [:index]

    namespace :reports do
      resource :infected, only: [:show]
      resource :non_infected, only: [:show]
      resource :inventories_overview, only: [:show]
      resource :resources_lost, only: [:show]
    end
  end
end
