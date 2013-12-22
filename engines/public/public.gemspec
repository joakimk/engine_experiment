require File.join(File.dirname(__FILE__), '../base/common_gemspec')

define_gem "public" do |s|
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
end
