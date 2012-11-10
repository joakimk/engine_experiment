require_relative "../../../lib/engine_loader"

namespace :spec do
  EngineLoader.known_engines.each do |engine|
    desc "Run all specs for engines/#{engine}"
    task engine do
      system("cd engines/#{engine} && rake spec")
    end
  end
end
