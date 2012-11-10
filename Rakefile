#!/usr/bin/env rake
require File.expand_path('../lib/tasks/no_rails_rake_tasks.rb', __FILE__)

# Load all non-rails tasks.
path = File.expand_path('../lib/tasks/no_rails', __FILE__)
Dir.entries(path).each do |file|
  next unless file.include?('.rb')
  require File.join(path, file)
end

NoRailsRakeTasks.load_rails_when_needed_with(Proc.new {
  require File.expand_path('../config/application', __FILE__)
  EngineExperiment::Application.load_tasks
})
