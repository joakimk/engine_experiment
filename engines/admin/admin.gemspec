require File.join(File.dirname(__FILE__), '../base/common_gemspec')

define_gem "admin" do |s|
  # Some slowloading gems to see if they only affect admin and upstream engines of admin
  s.add_dependency "sass"
  s.add_dependency "haml"
  s.add_dependency "slim"
  s.add_dependency "debitech"
  s.add_dependency "debitech_soap"
  s.add_dependency "prawn"
  s.add_dependency "httparty"
  s.add_dependency "will_paginate"
  s.add_dependency "rdiscount"
  s.add_dependency "paper_trail"
  s.add_dependency "newrelic_rpm"
  s.add_dependency "net-ssh"
  s.add_dependency "mini_magick"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
end

