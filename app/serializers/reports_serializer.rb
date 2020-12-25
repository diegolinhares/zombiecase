# frozen_string_literal: true

class ReportsSerializer
  include JSONAPI::Serializer
  include Rails.application.routes.url_helpers

  attribute :links

  def links
    [api_reports_infected_url,
      api_reports_non_infected_url,
      api_reports_inventories_overview_url,
      api_reports_resources_lost_url]
  end
  
end
