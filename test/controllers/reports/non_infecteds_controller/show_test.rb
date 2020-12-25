# frozen_string_literal: true

require 'test_helper'

module Reports
  class NonInfectedsControllerCreateTest < ActionDispatch::IntegrationTest
    include RequestHelper

    test 'should respond with ok status and show report links' do
      get reports_non_infected_url

      assert_response :ok

      assert_equal(
        {
          data: {
            report: {
              details: 'This number represents the percentage of non infected survivors ' \
                       'in relation to the total of registered survivors.',
              value: 0.67
            }
          }
        },
        json_response
      )
    end
  end
end
