class ApplicationController < MyApp
  get '/' do
    if authenticate(session)
      erb :index
    else
      erb :index_loggedout
    end
  end

  get '/games' do
    erb :games
  end

  get '/failure' do
    erb :failure
  end

  get '/library' do
    user = authenticate(session)
    @games = user.games if user

    erb :library
  end
end