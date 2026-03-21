# frozen_string_literal: true

require 'dotenv'

module Utility
  class EnvironmentFetcher
    DATABASE_SETUP_STRING = 'db'
    DEV_ENV_STRINGS = %w[dev development test] + [DATABASE_SETUP_STRING]

    class << self
      def postgres_url
        ENV.fetch('POSTGRES_URL')
      end

      def database_name
        ENV.fetch('POSTGRES_DB')
      end

      def pepper
        ENV.fetch('PEPPER')
      end

      def dev_env_strings
        DEV_ENV_STRINGS
      end

      def database_setup_env_string
        DATABASE_SETUP_STRING
      end
    end
  end
end
