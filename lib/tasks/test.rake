task :default => :environment do
  puts "Available engines: #{`ls engines`.chomp.split.join(', ')}"
  puts
  puts "Running the host rails app including all engines..."
  puts Customers::Customer.new(name: 'hello').name
  puts
  puts "Running all tests..."
  system("cd engines/base; rake spec spec:downstream")
end

desc "Show engine dependency trees"
task :deps do
  # Fetch all deps
  trees = []
  `ls engines`.chomp.split.each do |engine|
    deps = File.read("engines/#{engine}/engine.deps").split
    trees << deps.join(' -> ')
  end

  # Find the deepest trees
  known_trees = Set.new
  trees.each do |tree|
    deepest_tree = trees.find_all { |t| t.include?(tree) }.sort_by(&:length).last
    known_trees << deepest_tree
  end

  # Display
  known_trees.each do |tree|
    puts tree
  end
end
