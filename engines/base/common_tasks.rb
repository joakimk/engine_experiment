begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

APP_RAKEFILE = File.expand_path("../../Rakefile", __FILE__)

require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :spec do
  task :downstream do
    downstream_engines = []
    current_engine = Dir.pwd.split("/").last

    Dir.entries("..").each do |engine|
      deps_file = "../#{engine}/engine.deps"
      if File.exists?(deps_file)
        current_engine_found = false
        File.readlines(deps_file).map { |line| line.chomp }.each do |engine|
          if engine == current_engine
            current_engine_found = true
          elsif current_engine_found
            downstream_engines << engine unless downstream_engines.include?(engine)
          end
        end
      end
    end

    puts "Downstream engines: #{downstream_engines.join(', ')}"
    puts

    downstream_engines.each do |engine|
      puts "Running #{engine} tests."
      system("cd ../#{engine} && rake") || exit(1)
      puts
    end
  end
end
