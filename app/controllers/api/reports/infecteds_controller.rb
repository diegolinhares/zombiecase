# frozen_string_literal: true

module Api
  module Reports
    class InfectedsController < ApplicationController
      def show
        render_json(:ok, infected_report)
      end

      private

      def infected_report
        report = Report.infected

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
end
