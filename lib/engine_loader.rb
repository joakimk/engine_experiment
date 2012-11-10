class EngineLoader
  def self.load
    raise("Can't load engines twice") if @loaded_engine_names

    requested_engines = (ENV['ENGINES'] && ENV['ENGINES'].split(',')) || known_engines
    engines_to_load = Set.new

    requested_engines.each do |engine|
      deps_file_path = File.join(File.dirname(__FILE__), "../engines/#{engine}/engine.deps")
      engine_deps = File.readlines(deps_file_path).map(&:chomp)
      engines_to_load += engine_deps
    end

    engines_to_load.each do |engine|
      require_relative "../engines/#{engine}/engine"
    end

    @loaded_engine_names = engines_to_load.to_a
  end

  def self.known_engines
    @known_engines ||= YAML.load_file(File.join(File.dirname(__FILE__), "../config/known_engines.yml"))
  end

  def self.loaded_engine_names
    @loaded_engine_names || raise("Engines not loaded yet")
  end

  def self.loaded?(engine_name)
    loaded_engine_names.include?(engine_name.to_s)
  end

  def self.loaded_engines
    loaded_engine_names.map { |engine| eval(engine.camelcase + "::Engine") }
  end
end
