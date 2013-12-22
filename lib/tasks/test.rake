task :default => :environment do
  puts "Available engines: #{`ls engines`.chomp.split.join(', ')}"
  puts
  puts "Running the host rails app including all engines..."
  puts Customers::Customer.new(name: 'hello').name
  puts
  puts "Running all tests..."
  system("cd engines/base; BUNDLE_GEMFILE='' rake")
end
