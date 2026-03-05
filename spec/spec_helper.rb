# frozen_string_literal: true

ENV['ENV'] = 'test'

require 'database_cleaner-sequel'
require 'rspec'
require 'simplecov'
require './lib/config/initialize'

SimpleCov.minimum_coverage 100
SimpleCov.start do
  add_filter '/spec/'
  enable_coverage :branch
end

RSpec.configure do |config|
  config.color = true

  config.disable_monkey_patching!
  config.before(:suite) do
    DatabaseCleaner[:sequel].strategy = :transaction
    DatabaseCleaner[:sequel].clean_with(:truncation)
  end

  config.around { |example| DatabaseCleaner[:sequel].cleaning { example.run } }
end
