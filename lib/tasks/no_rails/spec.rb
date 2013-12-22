require_relative "../../../lib/engine_loader"

namespace :spec do
  EngineLoader.known_engines.each do |engine|
    desc "Run all specs for engines/#{engine} (and it's upstream deps)"
    task engine do
      system("cd engines/#{engine} && BUNDLE_GEMFILE='' rake")
    end
  end

  desc "Run all specs for all engines at once (in CI this would probably be different test jobs)"
  task :ci do
    threads = []
    EngineLoader.known_engines.each do |engine|
      threads << Thread.new { system("cd engines/#{engine} && BUNDLE_GEMFILE='' rake spec:local") }
    end
    threads.each(&:join)
  end
end
