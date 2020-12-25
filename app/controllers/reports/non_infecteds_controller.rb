# frozen_string_literal: true

module Reports
  class NonInfectedsController < ApplicationController
    def show
      render_json(:ok, non_infected_report)
    end

    private

    def non_infected_report
      report = Report.non_infected

      {
        data: {
          report: {
            details: report[:details],
            value: report[:value]
          }
        }
      }
    end
  end
end
