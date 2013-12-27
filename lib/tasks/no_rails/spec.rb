require_relative "../../../lib/engine_loader"

namespace :spec do
  EngineLoader.known_engines.each do |engine|
    desc "Run all specs for engines/#{engine} (and it's upstream deps)"
    task engine do
      system("cd engines/#{engine} && BUNDLE_GEMFILE='' rake")
    end
  end

  desc "Run specs that have changed since last commit or push"
  task  :changes do
    changed_files_since_last_push = `git whatchanged --oneline -n $(git status|grep ahead|awk '{ print $9 }') 2> /dev/null|grep ':'|awk '{ print $6 }'`.chomp.split("\n")
    uncommitted_changed_files = `git diff|grep '+++'`.split("\n").
      reject { |path| path.include?("lib/tasks/no_rails") || path.include?("uncommitted_changed_files") }.
      map { |line| line.split('+ b/').last.chomp }

    untracked_files = `git status --porcelain|grep '??'|awk '{ print $2 }'`.split("\n")

    all_changed_files = changed_files_since_last_push + uncommitted_changed_files + untracked_files

    changed_engines = []
    all_changed_files.each do |file|
      next unless file.start_with?("engines/")
      engine_name = file.match(/engines\/(.+?)\//)[1]
      changed_engines << engine_name
    end

    load "lib/engine_deps.rb"
    changed_engines.each do |engine|
      dependencies = EngineDeps.for(engine)

      # If any of the dependencies have changed, skip this engine because its specs
      # will be run as a result of running the tests in the dependency.
      next if changed_engines.any? { |engine| dependencies.include?(engine) }

      system("cd engines/#{engine} && BUNDLE_GEMFILE='' rake") || exit(1)
    end

    if changed_engines.none?
      puts "Nothing to do. Engine code has not changed."
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
