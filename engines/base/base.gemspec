$:.push File.expand_path("lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "base"
  s.version     = "1.0"
  s.authors     = [""]
  s.email       = [""]
  s.homepage    = ""
  s.summary     = ""
  s.description = ""

  s.files = Dir["{controllers,models,helpers,views,jobs,lib}/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
end
