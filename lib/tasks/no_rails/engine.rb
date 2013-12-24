require "active_support/core_ext"
require "colorize"

def run(*command)
  system(*command) || raise("Command failed: #{command}")
end

desc "Create new engine"
task :create_engine, [ :name ] do |_, args|
  engine = args[:name] || raise("Missing name")

  target_path = "engines/#{engine}"
  if File.exists?(target_path)
    raise "#{target_path} already exists"
  end

  print "Generating...".blue; STDOUT.flush
  run("cp -rf engines/template #{target_path}")
  run("mv", "#{target_path}/lib/template.rb", "#{target_path}/lib/#{engine}.rb")
  run("mv", "#{target_path}/template.gemspec", "#{target_path}/#{engine}.gemspec")

  Dir["#{target_path}/**/*"].each do |path|
    next unless Dir.exists?(path)
    run("mv", path, path.split("/")[0...-1].join("/") + "/#{engine}") if path.end_with?("template")
  end

  Dir["#{target_path}/**/*"].each do |path|
    next if Dir.exists?(path)
    str = File.read(path).gsub("template", engine).gsub("Template", engine.camelcase)
    File.write(path, str)
  end

  puts " done"
  puts
  run("find #{target_path}")

  puts
  puts "Bundling and running tests:".blue
  puts
  run("cd #{target_path} && export BUNDLE_GEMFILE='' && bundle 1> /dev/null && rake")

  puts
  puts "Engine ready (#{target_path})"
end
