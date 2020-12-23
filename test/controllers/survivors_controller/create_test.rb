require 'test_helper'

class SurvivorsControllerCreateTest < ActionDispatch::IntegrationTest
  include RequestHelper

  test 'should respond with unprocessable_entity status when receives invalid params' do
    post survivors_url, params: {
      survivor: {
        'latitude' => -100.00,
        'longitude' => -190.00,
        'age' => 'fourthy',
        'inventory' => {
          'water' => -1,
          'food' => -1,
          'ammunition' => -1,
          'medication' => -1
        }
      }
    }

    assert_response :unprocessable_entity

    assert_equal(
      {
        survivor: {
          name: ["can't be blank"],
          gender: ["can't be blank"],
          items: ['Water must be greater than or equal to 0',
                  'Food must be greater than or equal to 0',
                  'Medication must be greater than or equal to 0',
                  'Ammunition must be greater than or equal to 0'],
          age: ['is not a number'],
          latitude: ['must be greater than or equal to -90'],
          longitude: ['must be greater than or equal to -180']
        }
      },
      json_response
    )
  end

  test 'should respond with created status when receives valid params' do
    post survivors_url, params: {
      survivor: {
        'name' => 'Daryl Dixon',
        'gender' => 'male',
        'age' => 40,
        'latitude' => -90.00,
        'longitude' => -180.00,
        'inventory' => {
          'water' => 0,
          'food' => 0,
          'ammunition' => 0,
          'medication' => 0
        }
      }
    }

    assert_response :created

    assert_equal(
      {
        survivor: {
          id: 868534033,
          latitude: '-90.0',
          longitude: '-180.0',
          age: 40,
          name: 'Daryl Dixon',
          gender: 'male',
          items: {
            water: 0,
            food: 0,
            medication: 0,
            ammunition: 0
          }
        }
      },
      json_response
    )
  end
end
