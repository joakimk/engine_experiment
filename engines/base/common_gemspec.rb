def define_gem(name, &block)
  engine_gemspec = caller.first.split(':').first
  engine_path = File.dirname(engine_gemspec)
  $:.push File.expand_path("lib", engine_path)

  Gem::Specification.new do |s|
    s.name        = name
    s.version     = "1.0"
    s.authors     = [""]
    s.email       = [""]
    s.homepage    = ""
    s.summary     = ""
    s.description = ""

    s.files = Dir["{controllers,models,helpers,views,jobs,lib}/**/*"]

    block.call(s) if block
  end
end
