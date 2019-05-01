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
      session[:role] = user.role
      redirect "/"
    else
      @errors = {'Auth' => ['Email or password do not match']}
      redirect "/failure"
    end
  end

  get '/logout' do
    user = authenticate(session)
    if user
      user.update(:session_id => nil) if user && user.session_id == session[:session_id]
      
      session.clear
      redirect "/"
    else
      erb :failure
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
    user.role = :normal
    user.approval = :approved

    if user.save
      user.update(:session_id => session[:session_id])
      session[:firstname] = user.firstname
      session[:lastname] = user.lastname
      session[:email] = user.email
      session[:role] = user.role
      
      erb :post_register
    else
      @errors = user.errors.messages
      redirect "/failure"
    end
  end
end