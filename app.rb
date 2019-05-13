require 'sinatra'
require 'sinatra/activerecord'
require 'dotenv/load'
require 'require_all'

require_all 'app/models'
set :database_file, 'db/config.yml'


class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'app/public'
    set :views, 'app/views'
    set :session_secret, ENV['SESSION_SECRET']
    enable :sessions
  end

  def authenticate
    user = User.find_by(:id => session[:id])
    return user if user && user.session_id == session[:session_id]
    set_session(User.null_user)
    User.null_user
  end

  def set_session(user)
    session[:id] = user.id
  end

  def user_logged_in
    unless session[:id]
      redirect '/login'
    end
  end

  get '/' do
    authenticate
    erb :index
  end
  
  get '/failure' do
    erb :failure
  end
end