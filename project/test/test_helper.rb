ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup commodities fixtures in test/fixtures/*.yml for commodities tests in alphabetical order.
  fixtures :commodities

  # Add more helper methods to be used by commodities tests here...
end
