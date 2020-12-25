# frozen_string_literal: true

require 'test_helper'

module Api
  class TradesControllerCreateTest < ActionDispatch::IntegrationTest
    include RequestHelper

    test 'should respond with unprocessable_entity status when attempting to trade with self' do
      post api_survivor_trades_url(
        survivor_id: survivors(:daryl).id,
        params: {
          trade: {
            offer: {
              items: {
                water: 1
              }
            },
            for: {
              survivor_id: survivors(:daryl).id,
              items: {
                food: 1
              }
            }

          }
        }
      )

      assert_response :unprocessable_entity

      assert_equal(
        {
          errors: { for: [{ survivor_id: 'not allowed to trade with self' }] }
        },
        json_response
      )
    end

    test 'should respond with unprocessable_entity status when the target survivor does not exist or is infected' do
      post api_survivor_trades_url(
        survivor_id: survivors(:daryl).id,
        params: {
          trade: {
            offer: {
              items: {
                water: 1
              }
            },
            for: {
              survivor_id: survivors(:carol).id,
              items: {
                food: 1
              }
            }

          }
        }
      )

      assert_response :unprocessable_entity

      assert_equal(
        {
          errors: { for: [{ survivor_id: 'Survivor does not exist' }] }
        },
        json_response
      )
    end

    test 'should respond with unprocessable_entity status when the lists aren\'t worth the same' do
      post api_survivor_trades_url(
        survivor_id: survivors(:daryl).id,
        params: {
          trade: {
            offer: {
              items: {
                water: 1
              }
            },
            for: {
              survivor_id: survivors(:rick).id,
              items: {
                water: 1
              }
            }

          }
        }
      )

      assert_response :unprocessable_entity

      assert_equal(
        {
          errors: { for: [{ items: 'Invalid Offer, the items offered and received do not worth the same' }] }
        },
        json_response
      )
    end

    test 'should respond with unprocessable_entity status when there are not enough items to complete the trade' do
      post api_survivor_trades_url(
        survivor_id: survivors(:daryl).id,
        params: {
          trade: {
            offer: {
              items: {
                food: 1
              }
            },
            for: {
              survivor_id: survivors(:rick).id,
              items: {
                water: 3
              }
            }
          }
        }
      )

      assert_response :unprocessable_entity

      assert_equal(
        {
          errors: { for: { items: [{ water: 'Not enough items, only 1 available' }] } }
        },
        json_response
      )
    end

    test 'should respond with unprocessable_entity status when any of the items list is empty' do
      post api_survivor_trades_url(
        survivor_id: survivors(:daryl).id
      ),
           params: {
             'trade' => {
               'offer' => {
                 'items' => []
               },
               'for' => {
                 'survivor_id' => survivors(:rick).id,
                 'items' => []
               }
             }
           },
           as: :json

      assert_response :unprocessable_entity

      assert_equal(
        {
          errors: {
            offer: { items: 'Empty item-list is not allowed' },
            for: { items: 'Empty item-list is not allowed' }
          }
        },
        json_response
      )
    end

    test 'should respond with unprocessable_entity status when the item list has an invalid item' do
      post api_survivor_trades_url(
        survivor_id: survivors(:daryl).id
      ),
           params: {
             trade: {
               offer: {
                 items: {
                   chocolate: 1
                 }
               },
               for: {
                 survivor_id: survivors(:rick).id,
                 items: {
                   coke: 2
                 }
               }
             }
           },
           as: :json

      assert_response :unprocessable_entity

      assert_equal(
        {
          errors: {
            offer: {
              items: 'There is an invalid item in the list'
            },
            for: {
              items: 'There is an invalid item in the list'
            }
          }
        },
        json_response
      )
    end

    test 'should respond with ok status when trade is valid' do
      post api_survivor_trades_url(
        survivor_id: survivors(:daryl).id
      ),
           params: {
             trade: {
               offer: {
                 items: {
                   food: 2
                 }
               },
               for: {
                 survivor_id: survivors(:rick).id,
                 items: {
                   water: 1
                 }
               }
             }
           },
           as: :json

      assert_response :ok

      assert_equal(
        {
          data: {
            items: {
              water: 2,
              food: 0,
              medication: 2,
              ammunition: 5
            },
            age: 40,
            latitude: '-90.0',
            longitude: '-180.0',
            id: 75_949_319,
            name: 'Daryl Dixon',
            gender: 'male'
          }
        },
        json_response
      )
    end
  end
end
