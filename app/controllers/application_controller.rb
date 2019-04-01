class ApplicationController < MyApp
  get '/' do
    if authenticate(session)
      erb :index
    else
      erb :index_loggedout
    end
  end
end