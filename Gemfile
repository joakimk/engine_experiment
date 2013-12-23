source 'https://rubygems.org'

gem 'rails', '3.2.8'
gem 'sqlite3'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

load "lib/engine_loader.rb"
EngineLoader.known_engines.each do |engine|
  gem engine, path: "engines/#{engine}", require: false
end

gem 'jquery-rails'

group :development do
  gem "rspec-rails"
  gem "capybara"
end
