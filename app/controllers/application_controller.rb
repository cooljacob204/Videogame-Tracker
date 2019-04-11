class ApplicationController < MyApp
  get '/' do
    if authenticate(session)
      erb :index
    else
      erb :index_loggedout
    end
  end

  get '/games' do
    @games = Game.all
    user = authenticate(session)
    @user_games = {}
    if user
      @user_games = user.games.map{|game| [game.id, true]}.to_h
    end
    erb :games
  end

  get '/game/:id' do
    Game.find_by_id(params[:id]).name
  end

  get '/games/new' do
    erb :game_new
  end
  
  post '/games/new' do
    game = Game.new()
    game.name = params[:name]
    game.genre = params[:genre]
    game.publisher = params[:publisher]
    game.description = params[:description]

    if game.save
      redirect "game/#{game.id}"
    else
      require 'pry'
      binding.pry
    end
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