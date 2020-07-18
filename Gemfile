source 'https://rubygems.org'

gem 'activerecord'
gem 'bcrypt'
gem 'dotenv'
gem 'pg'
gem 'rake'
gem 'require_all'
gem 'sinatra'
gem 'sinatra-activerecord'
gem 'thin'

gem 'prometheus-client'

group :development do
  gem 'rerun' if Gem.win_platform?
  gem 'rubocop'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'rspec'
end

group :test, :development do
  gem 'pry'
  gem 'shotgun'
  gem 'wdm' if Gem.win_platform?
end
