# frozen_string_literal: true

class InfectionReportsController < ApplicationController
  def create
    InfectionReports::Create
      .call(survivor_id: params[:survivor_id], params: infection_report_params)
      .then(InfectionReports::SerializeAsJson)
      .on_success { |result| render_created_infection_report(result) }
      .on_failure(:invalid_infection_report) { |data| render_unprocessable_infection_report(data[:infection_report]) }
  end

  private

  def infection_report_params
    params.require(:infection_report).permit(:infected_id)
  end

  def render_created_infection_report(result)
    render_json(:created, survivor: result[:infection_report_as_json])
  end

  def render_unprocessable_infection_report(json)
    render_json(:unprocessable_entity, infection_report: json)
  end
end
