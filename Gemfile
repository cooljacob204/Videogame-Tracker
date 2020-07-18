source "https://rubygems.org"

gem 'sinatra'
gem 'activerecord'
gem 'sinatra-activerecord'
gem 'rake'
gem 'require_all'
gem 'pg'
gem 'thin'
gem 'dotenv'
gem 'bcrypt'

gem 'prometheus-client'

group :development do
  gem 'rerun' if Gem.win_platform?
end

group :test do
  gem 'launchy'
  gem 'rspec'
  gem 'capybara'
end

group :test, :development do
  gem 'pry'
  gem 'wdm' if Gem.win_platform?
  gem 'shotgun'
end
