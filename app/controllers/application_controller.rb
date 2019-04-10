class ApplicationController < MyApp
  get '/' do
    if authenticate(session)
      erb :index
    else
      erb :index_loggedout
    end
  end

  get '/failure' do
    erb :failure
  end

  get '/connect' do
    user = authenticate(session)
    if user.approved?
      #...
    else
      redirect '/'
    end
  end

  post '/local_ip' do
    user = authenticate(session)
    user.update(ip_addr: params[:ip]) if user
  end

  def authorize_guest(mac)
    url = ENV['CONTROLLER_URL']
    username = ENV['CONTROLLER_PASSWORD']
    password = ENV['CONTROLLER_USER']
    site_id = ENV['CONTROLLER_SITE']

    unifi = UnifiApi::Unifi.new(username: username, password: password, url: url)
    unifi.login
    unifi.site_find_by_id(site_id).authorize_guest(mac)

    unifi.logout
  end
end