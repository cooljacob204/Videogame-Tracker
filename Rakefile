ENV['RACK_ENV'] ||= 'development'

require_relative './app'
require 'sinatra/activerecord/rake'

namespace :db do
  task :load_config do
    require './app'
  end
end
