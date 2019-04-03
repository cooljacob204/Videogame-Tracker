class SessionsController < MyApp
  get '/login' do
    erb :login
  end

  post '/login' do
    user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password]) && user.approved?
      user.update(:session_id => session[:session_id])
      session[:firstname] = user.firstname
      session[:lastname] = user.lastname
      session[:email] = user.email
      session[:role] = :guest
      redirect "/"
    else
      redirect "/failure"
    end
  end

  get '/logout' do
    user = User.find_by(:email => session[:email])
    user.update(:session_id => nil) if user && user.session_id == session[:session_id]
    
    session.clear
    redirect "/"
  end

  get '/register' do
    erb :register
  end

  post '/register' do
    user = User.new
    user.firstname = params[:firstname]
    user.lastname = params[:lastname]
    user.password = params[:password]
    user.email = params[:email]
    user.role = :guest
    user.approval = :waiting

    if user.save
      erb :post_register
    else
      redirect "/failure"
    end
  end
end