class SessionController < MyApp
  get '/login' do
    erb :login
  end
end