require "sinatra"
require "sinatra/activerecord"
require 'dotenv/load'

Dir[File.join(File.dirname(__FILE__), "app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "app/controllers", "*.rb")].each {|f| require f}

class MyApp < Sinatra::Application
  configure do
    set :database_file, "db/config.yml"
    set :public_folder, 'app/public'
    set :views, "app/views"
		set :session_secret, "password_security"
		enable :sessions
	end

  get '/' do
    erb :index
  end
end