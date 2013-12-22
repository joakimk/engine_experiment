require File.join(File.dirname(__FILE__), 'common_gemspec')

define_gem "base" do |s|
  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "unicorn"
  s.add_dependency "sqlite3"
  s.add_dependency "colorize"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
end
