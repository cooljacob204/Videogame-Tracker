class ApplicationController < MyApp
  get '/' do
    authenticate(session)
    erb :index
  end

  get '/games' do
    @games = Game.all.order(:id)
    user = authenticate(session)
    @user_games = {}
    if user
      @user = user.cleaned
      @user_games = user.games.map{|game| [game.id, true]}.to_h
    else
      @user = User.null_user
    end
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
  
  get '/library' do
    user = authenticate(session)
    @games = user.games if user

    erb :library
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

    if !user
      @errors = {'Auth' => ['Error authenticating user']}
      erb :failure
    elsif !game
      @errors = {'Games' => ['Game not found']}
    end

    user.games.delete(game) if user.games.find_by_id(game.id)

    if params[:location] && params[:location] == 'library'
      redirect '/library'
    else
      redirect '/games'
    end
  end
  
  get '/failure' do
    erb :failure
  end
end