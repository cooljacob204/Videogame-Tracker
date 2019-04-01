class SessionsController < MyApp
  get '/login' do
    erb :login
  end

  post '/login' do
    user = User.find_by(:email => params[:email])
 
    if user && user.authenticate(params[:password])
      "#{user.firstname}"
    else
      redirect "/failure"
    end
  end

  get '/register' do
    erb :register
  end

  post '/register' do
    user = User.new(params)

    if user.save
      redirect "/login"
    else
      redirect "/failure"
    end
  end
end