require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require_relative "../lib/sagas"

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!
  config.order = :random
end