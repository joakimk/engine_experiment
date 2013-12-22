require File.join(File.dirname(__FILE__), '../base/common_gemspec')

define_gem "customers" do |s|
  s.add_development_dependency "rspec-rails"
end
