# frozen_string_literal: true

require 'test_helper'

module Api
  module Reports
    class InventoriesOverviewsControllerCreateTest < ActionDispatch::IntegrationTest
      include RequestHelper

      test 'should respond with ok status and show report links' do
        get api_reports_inventories_overview_url

        assert_response :ok

        assert_equal(
          {
            data: {
              report: {
                details: 'This report contains the average amount of each type of item ' \
                         'that are in the non-infected survivors\' inventories',
                value: {
                  water: 1.0,
                  food: 0.5,
                  medication: 0.67,
                  ammunition: 0.33
                }
              }
            }
          },
          json_response
        )
      end
    end
  end
end
