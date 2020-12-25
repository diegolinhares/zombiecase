# frozen_string_literal: true

module Reports
  class InventoriesOverviewsController < ApplicationController
    def show
      render_json(:ok, inventories_overview)
    end

    private

    def inventories_overview
      report = Report.inventories_overview

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
