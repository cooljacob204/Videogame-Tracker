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
gem 'unifi_api', :git => 'https://github.com/cooljacob204/unifi_api.git'

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
