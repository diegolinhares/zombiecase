# frozen_string_literal: true

require 'test_helper'

module Api
  class InfectionReportsControllerCreateTest < ActionDispatch::IntegrationTest
    include RequestHelper

    test 'should respond with unprocessable_entity status when survivor reports itself' do
      post api_survivor_infection_reports_url(survivor_id: survivors(:daryl).id,
                                              params:
                                              {
                                                infection_report: {
                                                  infected_id: survivors(:daryl).id
                                                }
                                              }), headers: json_api_headers

      assert_response :unprocessable_entity

      assert_equal(
        {
          errors: {
            infected_id: ["can't flag yourself as an infected"]
          }
        },
        json_response
      )
    end

    test 'should respond with unprocessable_entity status when survivor has already been reported' do
      post api_survivor_infection_reports_url(survivor_id: survivors(:daryl).id,
                                              params:
                                              {
                                                infection_report: {
                                                  infected_id: survivors(:carol).id
                                                }
                                              }), headers: json_api_headers

      assert_response :unprocessable_entity

      assert_equal(
        {
          errors: {
            infected_id: ['has already been reported']
          }
        },
        json_response
      )
    end

    test 'should respond with created status when survivor is reported' do
      post api_survivor_infection_reports_url(survivor_id: survivors(:daryl).id,
                                              params:
                                              {
                                                infection_report: {
                                                  infected_id: survivors(:rick).id
                                                }
                                              }), headers: json_api_headers

      assert_response :created

      assert_equal(
        {
          data:
           {
             id: '139657800',
             type: 'infection-reports',
             relationships:
                  {
                    survivor:
                     {
                       data:
                        {
                          id: '75949319',
                          type: 'survivor'
                        }
                     },
                    'infected-survivor':
                           {
                             data:
                              {
                                id: '868534032',
                                type: 'survivor'
                              }
                           }
                  }
           }
        },
        json_response
      )
    end
  end
end
