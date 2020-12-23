require 'test_helper'

class InfectionReportsControllerCreateTest < ActionDispatch::IntegrationTest
  include RequestHelper

  test 'should respond with unprocessable_entity status when survivor reports itself' do
    post survivor_infection_reports_url(survivor_id: survivor_id,
                                        params: {
                                          'infection_report': {
                                            'infected_id' => survivor_id
                                          }
                                        })

    assert_response :unprocessable_entity

    assert_equal(
      {
        infection_report: {
          infected_id: ["can't flag yourself as an infected"]
        }
      },
      json_response
    )
  end

  test 'should respond with unprocessable_entity status when survivor has already been reported' do
    post survivor_infection_reports_url(survivor_id: survivor_id,
                                        params: {
                                          'infection_report': {
                                            'infected_id' => already_reported_id
                                          }
                                        })

    assert_response :unprocessable_entity

    assert_equal(
      {
        infection_report: {
          infected_id: ['has already been reported']
        }
      },
      json_response
    )
  end

  test 'should respond with created status when survivor has already been reported' do
    post survivor_infection_reports_url(survivor_id: survivor_id,
                                        params: {
                                          'infection_report': {
                                            'infected_id' => infected_id
                                          }
                                        })

    assert_response :created

    assert_equal(
      {
        survivor: {
          'survivor': { id: 75_949_319 },
          'infected-survivor': { id: 868_534_032 }
        }
      },
      json_response
    )
  end

  def survivor_id
    survivors(:daryl).id
  end

  def infected_id
    survivors(:rick).id
  end

  def already_reported_id
    survivors(:carol).id
  end
end
