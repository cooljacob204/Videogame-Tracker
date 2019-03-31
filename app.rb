require "sinatra/base"
require "sinatra/activerecord"
require 'dotenv/load'
require 'require_all'

require_all 'app/models'

class MyApp < Sinatra::Base
  configure do
    set :database_file, "db/config.yml"
    set :public_folder, 'app/public'
    set :views, "app/views"
		set :session_secret, "password_security"
		enable :sessions
  end
end