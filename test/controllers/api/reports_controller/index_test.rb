# frozen_string_literal: true

require 'test_helper'

module Api
  class ReportsControllerCreateTest < ActionDispatch::IntegrationTest
    include RequestHelper

    test 'should respond with ok status and show report links' do
      get api_reports_url, headers: json_api_headers

      assert_response :ok

      assert_equal(
        {
          data: nil,
          links: ['http://api.example.com/reports/infected',
                  'http://api.example.com/reports/non_infected',
                  'http://api.example.com/reports/inventories_overview',
                  'http://api.example.com/reports/resources_lost']
        },
        json_response
      )
    end
  end
end
