# frozen_string_literal: true

module Api
  class InfectionReportsController < ApplicationController
    def create
      InfectionReports::Create.call(survivor_id: params[:survivor_id], params: infection_report_params) do |on|
        on.then(InfectionReports::SerializeAsJson, serializer: InfectionReportsSerializer)
        on.success { |result| render_created_infection_report(result) }
        on.failure(:invalid_infection_report) { |data| render_unprocessable_infection_report(data[:infection_report]) }
      end
    end

    private

    def infection_report_params
      params.require(:infection_report).permit(:infected_id)
    end

    def render_created_infection_report(result)
      render_json(:created, result[:infection_report_as_json])
    end

    def render_unprocessable_infection_report(json)
      render_json(:unprocessable_entity, errors: json)
    end
  end
end
