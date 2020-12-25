# frozen_string_literal: true

class ReportsController < ApplicationController
  def index
    json = 
    {
      data: nil,
      links: [
        reports_infected_url,
        reports_non_infected_url,
        reports_inventories_overview_url,
        reports_resources_lost_url
      ]
    }
    render_json(:ok, json)
  end
end
