# frozen_string_literal: true

require 'sequel'

module Tasks
  module Helpers
    class DatabaseManager
      class << self
        def create
          with_postgres do |db|
            if database_exists?(db)
              warn "Database #{db_name} already exists"
            else
              db.execute("CREATE DATABASE \"#{db_name}\"")
              puts "Database #{db_name} successfully created"
            end
          end
        end

        def drop
          with_postgres do |db|
            if database_exists?(db)
              db.execute("DROP DATABASE \"#{db_name}\" WITH (FORCE)")
              puts "Database #{db_name} successfully dropped"
            else
              warn "Database #{db_name} not found"
            end
          end
        end

        def migrate(args)
          run_migration(args[:version]&.to_i)
        end

        private

        def run_migration(target = nil)
          require 'sequel'
          require './lib/config/initialize'
          Sequel.extension :migration

          directory = 'migrations'

          return warn 'No migration files found' unless Dir.exist?(directory) && !Dir.empty?(directory)

          puts "Migrating to #{target ? "version #{target}" : 'latest'}"
          with_postgres do |db|
            Sequel::Migrator.run(db, directory, target:)
            puts "Database #{db_name} successfully migrated"
          end
        end

        def with_postgres(&)
          root_url = EnvironmentFetcher.postgres_url.gsub(%r{/[^/]+$}, '/postgres')
          Sequel.connect(root_url, &)
        end

        def database_exists?(database)
          database.execute("SELECT 1 from pg_database WHERE datname='#{db_name}'") == 1
        end

        def db_name
          EnvironmentFetcher.database_name
        end
      end
    end
  end
end
