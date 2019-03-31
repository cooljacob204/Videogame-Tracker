require "sinatra"
require "sinatra/activerecord"

set :database_file, "./db/config.yml"

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../app/controllers", "*.rb")].each {|f| require f}

class MyApp < Sinatra::Application
  enable :sessions

end