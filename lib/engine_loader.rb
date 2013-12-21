require "yaml"

class EngineLoader
  def self.load
    raise("Can't load engines twice") if @loaded_engines

    engines_to_load = Set.new

    requested_engines.each do |engine|
      deps_file_path = File.join(File.dirname(__FILE__), "../engines/#{engine}/engine.deps")
      engine_deps = File.readlines(deps_file_path).map(&:chomp)
      engines_to_load += engine_deps
    end

    engines_to_load.each do |engine|
      require_relative "../engines/#{engine}/engine"
    end

    @loaded_engines = engines_to_load.to_a
  end

  def self.requested_engines
    if Dir.pwd.include?("engines/")
      [ Dir.pwd.split('/').last ]
    else
      (ENV['ENGINES'] && ENV['ENGINES'].split(',')) || known_engines
    end
  end

  def self.known_engines
    @known_engines ||= YAML.load_file(File.join(File.dirname(__FILE__), "../config/known_engines.yml"))
  end

  def self.loaded_engines
    @loaded_engines || raise("Engines not loaded yet")
  end

  def self.loaded?(engine_name)
    loaded_engines.include?(engine_name.to_s)
  end

  def self.loaded_engine_classes
    loaded_engines.map { |engine| eval(engine.camelcase + "::Engine") }
  end
end
