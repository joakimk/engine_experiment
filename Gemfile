source 'https://rubygems.org'

gem 'rails', '3.2.8'
gem 'sqlite3'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

$all_known_engines = [ "base", "customers", "content", "public", "admin", "cms" ]
$all_known_engines.each do |engine|
  gem engine, path: "engines/#{engine}", require: false
end

group :development do
  gem "rspec-rails"
  gem "capybara"
end
