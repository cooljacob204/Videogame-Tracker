class SessionsController < MyApp
  get '/login' do
    erb :login
  end
end