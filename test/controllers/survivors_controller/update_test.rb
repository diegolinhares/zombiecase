# frozen_string_literal: true

require 'test_helper'

class SurvivorsControllerUpdateTest < ActionDispatch::IntegrationTest
  include RequestHelper

  test "should respond with not_found status when survivor doesn't exists" do
    put survivor_url(id: 1,
                     params: {
                       survivor: {
                         'latitude' => -100.00,
                         'longitude' => -190.00
                       }
                     })

    assert_response :not_found

    assert_equal(
      {
        survivor: {
          id: 'not found'
        }
      },
      json_response
    )
  end

  test 'should respond with unprocessable_entity status when receives invalid params' do
    put survivor_url(id: survivors(:daryl).id,
                     params: {
                       survivor: {
                         'latitude' => 'nine degrees',
                         'longitude' => -190.00
                       }
                     })

    assert_response :unprocessable_entity

    assert_equal(
      {
        survivor:
        {
          latitude: ['is not a number'],
          longitude: ['must be greater than or equal to -180']
        }
      },
      json_response
    )
  end

  test 'should respond with ok status when receives valid params' do
    put survivor_url(id: survivors(:daryl).id,
                     params: {
                       survivor: {
                         'latitude' => -70.00,
                         'longitude' => -170.00
                       }
                     })

    assert_response :ok

    assert_equal(
      {
        survivor: {
          id: 75_949_319,
          latitude: '-70.0',
          longitude: '-170.0',
          age: 40,
          name: 'Daryl Dixon',
          gender: 'male',
          items: {
            water: 1,
            food: 2,
            medication: 2,
            ammunition: 5
          }
        }
      },
      json_response
    )
  end
end
