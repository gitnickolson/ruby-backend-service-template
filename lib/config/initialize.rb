# frozen_string_literal: true

require 'sequel'
require 'dotenv'
require 'zeitwerk'

DATABASE_SETUP_STRING = 'db'
DEV_STRINGS = (%w[dev development test] + [DATABASE_SETUP_STRING]).freeze

loader = Zeitwerk::Loader.new
loader.push_dir(File.expand_path('..', __dir__))
loader.setup

environment = ENV['ENV']&.downcase
if environment == 'production'
  Dotenv.load
elsif DEV_STRINGS.include?(environment) || environment.nil?
  project_root = File.expand_path('../../', __dir__)
  env_path = File.join(project_root, '.env.development')

  puts "Loading env from: #{env_path}"
  Dotenv.load(env_path)
end

return if environment == DATABASE_SETUP_STRING

DB = Sequel.connect(EnvironmentFetcher.postgres_url)
