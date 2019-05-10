class UsersController < ApplicationController
  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password]) && user.approved?
      user.update(:session_id => session[:session_id])
      set_session(user)
      redirect "/"
    else
      @errors = {'Auth' => ['Email or password do not match']}
      erb :'users/login'
    end
  end

  get '/logout' do
    user = authenticate(session)
    if user
      user.update(:session_id => nil) if user && user.session_id == session[:session_id]
      set_session(User.null_user)

      redirect "/"
    else
      erb :failure
    end
  end

  get '/register' do
    erb :'users/register'
  end

  post '/register' do
    user = User.new
    user.firstname = params[:firstname]
    user.lastname = params[:lastname]
    user.password = params[:password]
    user.email = params[:email]
    user.role = :normal
    user.approval = :approved

    if user.save
      user.update(:session_id => session[:session_id])
      set_session(user)
      
      erb :'users/post_register'
    else
      @errors = user.errors.messages
      redirect "/failure"
    end
  end
end