class LibraryController < ApplicationController
  get '/library' do
    user_logged_in 
    user = authenticate(session)
    @games = user.games if user.games

    erb :'library/index'
  end

  get '/library/:id/add' do
    user = authenticate(session)
    game = Game.find_by_id(params[:id])
    
    if !user
      @errors = {'Auth' => ['Error authenticating user']}
      erb :failure
    elsif !game
      @errors = {'Games' => ['Game not found']}
    end

    user.games << game if !user.games.find_by_id(game.id)
      
    redirect '/games'
  end

  get '/library/:id/remove' do
    user = authenticate(session)
    game = Game.find_by_id(params[:id])

    if !user.email
      @errors = {'Auth' => ['Error authenticating user']}
      erb :failure
    elsif !game
      @errors = {'Games' => ['Game not found']}
    end

    if user.games && user.games.find_by_id(game.id)
      user.games.delete(game)
    end

    if params[:location] && params[:location] == 'library'
      redirect '/library'
    else
      redirect '/games'
    end
  end
end