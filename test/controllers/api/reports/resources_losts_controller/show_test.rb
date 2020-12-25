# frozen_string_literal: true

require 'test_helper'

module Api
  module Reports
    class ResourcesLostsControllerCreateTest < ActionDispatch::IntegrationTest
      include RequestHelper

      test 'should respond with ok status and show report links' do
        get api_reports_resources_lost_url

        assert_response :ok

        assert_equal(
          {
            data:
            {
              report: {
                details: 'This report represents the values in points of all resources ' \
                         'that were lost because their owner are infected',
                value: 5
              }
            }
          },
          json_response
        )
      end
    end
  end
end
