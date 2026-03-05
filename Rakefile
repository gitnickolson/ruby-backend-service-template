# frozen_string_literal: true

require 'rake'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'
require './lib/config/initialize'

Dir.glob('lib/tasks/*.rake') { |file| import file }

RuboCop::RakeTask.new
RSpec::Core::RakeTask.new(:spec)

task default: %i[spec rubocop]
