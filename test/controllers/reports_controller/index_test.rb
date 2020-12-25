# frozen_string_literal: true

require 'test_helper'

class ReportsControllerCreateTest < ActionDispatch::IntegrationTest
  include RequestHelper

  test 'should respond with ok status and show report links' do
    get reports_url

    assert_response :ok

    assert_equal(
      {
        data: nil,
        links: ['http://www.example.com/reports/infected',
                'http://www.example.com/reports/non_infected',
                'http://www.example.com/reports/inventories_overview',
                'http://www.example.com/reports/resources_lost']
      },
      json_response
    )
  end
end
