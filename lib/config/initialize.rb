# frozen_string_literal: true

require 'dotenv'
require 'model_schema'
require 'openapi_first'
require 'sequel'
require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.push_dir(File.expand_path('..', __dir__))
loader.setup

project_root = File.expand_path('../../', __dir__)

environment = ENV['ENV']&.downcase
if environment == 'production'
  env_path = File.join(project_root, '.env')
elsif Utility::EnvironmentFetcher.dev_env_strings.include?(environment) || environment.nil?
  env_path = File.join(project_root, '.env.development')
  OpenapiFirst.register('openapi/openapi.yml')
end

Dotenv.load(env_path)
puts "Loading env from: #{env_path}"

return if environment == Utility::EnvironmentFetcher.database_setup_env_string

Sequel::Model.plugin(ModelSchema::Plugin)
DB = Sequel.connect(Utility::EnvironmentFetcher.postgres_url)
