# frozen_string_literal: true

require 'rake'

namespace :db do
  desc 'Create database'
  task :create do
    Tasks::Helpers::DatabaseManager.create
  end

  desc 'Drop database'
  task :drop do
    Tasks::Helpers::DatabaseManager.drop
  end

  desc 'Run database migrations'
  task :migrate, %i[version] do |_, args|
    Tasks::Helpers::DatabaseManager.migrate(args)
  end
end
