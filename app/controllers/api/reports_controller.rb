# frozen_string_literal: true

module Api
  class ReportsController < ApplicationController
    def index
      json =
        {
          data: nil,
          links: [
            api_reports_infected_url,
            api_reports_non_infected_url,
            api_reports_inventories_overview_url,
            api_reports_resources_lost_url
          ]
        }
      render_json(:ok, json)
    end
  end
end
