# frozen_string_literal: true

ENV['ENV'] = 'test'

require 'database_cleaner-sequel'
require 'factory_bot'
require 'openapi_first'
require 'rack/test'
require 'rspec'
require 'simplecov'
require 'timecop'

require './lib/config/initialize'
require './lib/web/router'

# Rack needs this method to work in tests
def app
  Web::Router.new
end

def set_up_openapi_first
  OpenapiFirst::Test.setup
end

def set_up_simplecov
  SimpleCov.minimum_coverage 100
  SimpleCov.start do
    add_filter '/spec/'
    enable_coverage :branch
  end
end

def configure_rspec # rubocop:disable Metrics/MethodLength
  RSpec.configure do |config|
    config.color = true
    config.disable_monkey_patching!

    config.include FactoryBot::Syntax::Methods
    config.include OpenapiFirst::Test::Methods[app]
    config.include(Rack::Test::Methods)

    config.before(:suite) do
      FactoryBot.find_definitions
      DatabaseCleaner[:sequel].strategy = :transaction
      DatabaseCleaner[:sequel].clean_with(:truncation)
    end
    config.around { |example| DatabaseCleaner[:sequel].cleaning { example.run } }
    config.after { Timecop.unfreeze }
  end
end

set_up_simplecov
configure_rspec
