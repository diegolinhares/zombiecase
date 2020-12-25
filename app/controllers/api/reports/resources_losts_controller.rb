# frozen_string_literal: true

module Api
  module Reports
    class ResourcesLostsController < ApplicationController
      def show
        render_json(:ok, resources_lost)
      end

      private

      def resources_lost
        report = Report.resources_lost

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
