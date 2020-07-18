class GamesController < ApplicationController
  get '/games' do
    @games = Game.all.order(:id)
    user = authenticate
    @role = user.role
    @user_games = {}
    @user_games = user.games.map { |game| [game.id, true] }.to_h if user.games

    erb :'games/index'
  end

  get '/game/:id' do
    @game = Game.find_by_id(params[:id])

    erb :'games/show'
  end

  get '/game/:id/edit' do
    user = authenticate
    @game = Game.find_by_id(params[:id])
    unless user && (@game.creator == authenticate || user.admin? || user.moderator?)
      @errors = { 'Auth' => ['You do not have permissions to edit the game'] }
      return erb :failure
    end
    if @game
      erb :'games/edit'
    else
      @errors = { 'error' => ['game not found'] }
      erb :failure
    end
  end

  put '/game/:id' do
    user = authenticate
    game = Game.find_by_id(params[:id])

    unless user && (game.creator == authenticate || user.admin? || user.moderator?)
      @errors = { 'Auth' => ['You do not have permissions to edit the game'] }
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

  delete '/game/:id' do
    user = authenticate
    game = Game.find_by_id(params[:id])

    unless game
      @errors = { 'error' => ['game not found'] }
      status 404
      return erb :failure
    end

    unless user && (game.creator == authenticate || user.admin? || user.moderator?)
      @errors = { 'Auth' => ['You do not have permissions to delete the game'] }
      status 401
      return erb :failure
    end

    if game.delete
      redirect '/games'
    else
      @errors = { 'error' => ['internal server error'] }
      status 500
      erb :failure
    end
  end

  get '/games/new' do
    erb :'games/new'
  end

  post '/games/new' do
    game = Game.new
    game.name = params[:name]
    game.genre = params[:genre]
    game.publisher = params[:publisher]
    game.description = params[:description]
    game.creator = authenticate

    if game.save
      redirect "game/#{game.id}"
    else
      @errors = game.errors.messages
      erb :failure
    end
  end
end
