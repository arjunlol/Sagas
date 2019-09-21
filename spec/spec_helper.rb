require 'simplecov'
require 'pry-byebug'
SimpleCov.start do
  add_filter '/spec/'
end

require_relative '../lib/sagas'
require_relative '../lib/sagas/command'
require_relative '../lib/sagas/transaction'

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!
  config.order = :random
end
