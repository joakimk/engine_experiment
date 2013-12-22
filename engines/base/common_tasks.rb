begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require "colorize"
require "rspec/core/rake_task"

task :default => "spec:all"

namespace :spec do
  task :all => [ "spec:local", "spec:upstream" ]
  task :local => [ "header", "spec:unit", "spec" ]

  task :header do
    puts "#{engine_name}:".blue
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
    engines = find_engines
    @seen_engines = []
    run_upstream_specs(engines, engine_name)
  end

  def engine_name
    Dir.pwd.split("/").last
  end

  def find_engines
    Dir.entries("..").each_with_object({}) { |engine, h|
      deps_file = "../#{engine}/engine.deps"
      next unless File.exists?(deps_file)
      h[engine] = File.readlines(deps_file).map(&:chomp)
    }
  end

  def run_upstream_specs(engines, current_engine)
    engines.each do |engine, deps|
      if deps.include?(current_engine) && engine != current_engine &&
        !@seen_engines.include?(engine)
        puts
        run_specs(engine)
        run_upstream_specs(engines, engine)
        @seen_engines << engine
      end
    end
  end

  def run_specs(engine)
    run("cd ../#{engine} && BUNDLE_GEMFILE='' rake spec:local")
  end

  def run(command)
    system(command) || exit(1)
  end
end
