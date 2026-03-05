# frozen_string_literal: true

require 'sequel'
require 'dotenv'
require 'zeitwerk'

DATABASE_SETUP_STRING = 'db'
DEV_STRINGS = (%w[dev development test] + [DATABASE_SETUP_STRING]).freeze

loader = Zeitwerk::Loader.new
loader.push_dir(File.expand_path('..', __dir__))
loader.setup

project_root = File.expand_path('../../', __dir__)

environment = ENV['ENV']&.downcase
if environment == 'production'
  env_path = File.join(project_root, '.env')
elsif DEV_STRINGS.include?(environment) || environment.nil?
  env_path = File.join(project_root, '.env.development')
end

Dotenv.load(env_path)
puts "Loading env from: #{env_path}"

return if environment == DATABASE_SETUP_STRING

DB = Sequel.connect(EnvironmentFetcher.postgres_url)
