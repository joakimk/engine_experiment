require_relative "../../engine_deps"

desc "Show engine dependency trees"
task :deps do
  # Fetch all deps
  trees = []
  `ls engines`.chomp.split.each do |engine|
    trees << EngineDeps.for(engine) + [ engine ]
  end

  # Find the deepest trees
  known_trees = Set.new
  trees.each do |tree|
    deepest_tree = trees.find_all { |t| t.sort.find_all { |tt| tree.include?(tt) }.size == tree.size }.sort_by(&:length).last
    known_trees << [ deepest_tree[0..-2].join(', '), deepest_tree[-1] ].flatten.join(' -> ')
  end

  # Display
  known_trees.each do |tree|
    puts tree
  end
end
