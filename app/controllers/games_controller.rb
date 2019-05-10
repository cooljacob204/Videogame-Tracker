class GamesController < ApplicationController
  get '/' do
    authenticate(session)
    erb :index
  end

  get '/games' do
    @games = Game.all.order(:id)
    user = authenticate(session)
    @role = user.role
    @user_games = {}
    @user_games = user.games.map{|game| [game.id, true]}.to_h if user.games

    erb :games
  end

  get '/game/:id' do
    @game = Game.find_by_id(params[:id])

    erb :game
  end

  get '/game/:id/edit' do
    user = authenticate(session)
    @game = Game.find_by_id(params[:id])
    unless user && (@game.creator == authenticate(session) || user.admin? || user.moderator?)
      @errors = {'Auth' => ['You do not have permissions to edit the game']}
      return erb :failure
    end
    if @game
      erb :game_edit
    else
      @errors = {'error' => ['game not found']}
      erb :failure
    end
  end

  post '/game/:id/edit' do
    user = authenticate(session)
    game = Game.find_by_id(params[:id])

    unless user && (game.creator == authenticate(session) || user.admin? || user.moderator?)
      @errors = {'Auth' => ['You do not have permissions to edit the game']}
      return erb :failure
    end
    
    game.name = params[:name]
    game.genre = params[:genre]
    game.publisher = params[:publisher]
    game.description = params[:description]

    if game.save
      redirect "/game/#{game.id}"
    else
      @errors = game.errors.messages
      erb :failure
    end
  end

  get '/game/:id/delete' do
    user = authenticate(session)
    game = Game.find_by_id(params[:id])
    unless user && (game.creator == authenticate(session) || user.admin? || user.moderator?)
      @errors = {'Auth' => ['You do not have permissions to delete the game']}
      return erb :failure
    end
    if game.delete
      redirect '/games'
    else
      @arrors = {'error' => ['game not found']}
      erb :failure
    end
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
    game.creator = authenticate(session)

    if game.save
      redirect "game/#{game.id}"
    else
      @errors = game.errors.messages
      erb :failure
    end
  end
  
  get '/failure' do
    erb :failure
  end
end