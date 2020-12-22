ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

Rails.root.join('test/support').then do |pathname|
  require pathname.join('request_helper')
end

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)

  fixtures :all
end
