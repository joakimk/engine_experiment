require File.join(File.dirname(__FILE__), '../base/common_gemspec')

define_gem "template" do |s|
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "database_cleaner"
end
