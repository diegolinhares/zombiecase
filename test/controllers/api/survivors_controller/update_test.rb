# frozen_string_literal: true

require 'test_helper'

module Api
  class SurvivorsControllerUpdateTest < ActionDispatch::IntegrationTest
    include RequestHelper

    test "should respond with not_found status when survivor doesn't exists" do
      put api_survivor_url(id: 1,
                           params: {
                             survivor: {
                               latitude: -100.00,
                               longitude: -190.00
                             }
                           }), headers: json_api_headers

      assert_response :not_found

      assert_equal(
        {
          errors: {
            id: 'not found'
          }
        },
        json_response
      )
    end

    test 'should respond with unprocessable_entity status when receives invalid params' do
      put api_survivor_url(id: survivors(:daryl).id,
                           params: {
                             survivor: {
                               latitude: 'nine degrees',
                               longitude: -190.00
                             }
                           }), headers: json_api_headers

      assert_response :unprocessable_entity

      assert_equal(
        {
          errors:
          {
            latitude: ['is not a number'],
            longitude: ['must be greater than or equal to -180']
          }
        },
        json_response
      )
    end

    test 'should respond with ok status when receives valid params' do
      put api_survivor_url(id: survivors(:daryl).id,
                           params: {
                             survivor: {
                               latitude: -70.00,
                               longitude: -170.00
                             }
                           }), headers: json_api_headers

      assert_response :ok

      assert_equal(
        {
          data: {
            id: '75949319',
            type: 'survivor',
            attributes:
            {
              name: 'Daryl Dixon',
              age: 40,
              gender: 'male',
              latitude: '-70.0',
              longitude: '-170.0',

              items: {
                water: 1,
                food: 2,
                medication: 2,
                ammunition: 5
              }
            }
          }
        },
        json_response
      )
    end
  end
end
