begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require "colorize"
require "rspec/core/rake_task"

task :default => "spec:all"

namespace :spec do
  task :all => [ "spec:local", "spacer", "spec:upstream" ] do
  end

  task :local => [ "spec:unit", "spacer", "spec" ] do
  end

  task :spacer do
    puts
  end

  task :unit do
    if Dir["unit/*_spec.rb"].any?
      puts "Running unit tests..."
      system("rspec unit/*_spec.rb") || exit(1)
    end
  end

  task :spec do
    puts "Running integrated tests..."
    system("rspec", "--color", "--tty", *Dir["spec/**/*_spec.rb"]) || exit(1)
  end

  task :upstream do
    upstream_engines = []
    current_engine = Dir.pwd.split("/").last

    Dir.entries("..").each do |engine|
      deps_file = "../#{engine}/engine.deps"
      if File.exists?(deps_file)
        current_engine_found = false
        File.readlines(deps_file).map { |line| line.chomp }.each do |engine|
          if engine == current_engine
            current_engine_found = true
          elsif current_engine_found
            upstream_engines << engine unless upstream_engines.include?(engine)
          end
        end
      end
    end

    upstream_engines.each do |engine|
      puts
      puts "#{engine.capitalize}:".blue
      system("cd ../#{engine} && BUNDLE_GEMFILE='' rake spec:local") || exit(1)
      puts
    end
  end
end
