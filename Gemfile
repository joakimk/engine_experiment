source 'https://rubygems.org'

gem 'rails', '3.2.8'
gem 'sqlite3'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

[ "base", "customers" ].each do |engine|
  gem engine, path: "engines/#{engine}", require: "#{File.dirname(__FILE__)}/engines/#{engine}/engine"
end

group :development do
  gem "rspec-rails"
end
