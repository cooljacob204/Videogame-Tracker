require 'sinatra'
require 'sinatra/activerecord'
require 'dotenv/load'
require 'prometheus/client'
require 'prometheus/middleware/collector'
require 'prometheus/middleware/exporter'
require 'require_all'

require_all 'app/models'
set :database_file, 'db/config.yml'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'app/public'
    set :views, 'app/views'
    use Rack::Session::Cookie, key: 'rack.session',
                               path: '/',
                               secret: ENV['SESSION_SECRET']
  end

  def authenticate
    user = User.find_by(id: session[:id])
    return user if user && user.session_id == session[:session_id].to_s

    set_session(User.null_user)
    User.null_user
  end

  def set_session(user)
    session[:id] = user.id
  end

  def user_logged_in
    redirect '/login' unless session[:id]
  end

  get '/' do
    authenticate
    erb :index
  end

  get '/failure' do
    erb :failure
  end
end
