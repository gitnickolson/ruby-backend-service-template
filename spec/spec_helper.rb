# frozen_string_literal: true

ENV['ENV'] = 'test'

require './lib/config/initialize'
require 'rspec'
require 'database_cleaner-sequel'

RSpec.configure do |config|
  config.color = true

  config.disable_monkey_patching!
  config.before(:suite) do
    DatabaseCleaner[:sequel].strategy = :transaction
    DatabaseCleaner[:sequel].clean_with(:truncation)
  end

  config.around { |example| DatabaseCleaner[:sequel].cleaning { example.run } }
end
