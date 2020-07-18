require "ipaddr"

class MediaValidation
  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)

    allowed_networks = IPAddr.new("10.0.0.0/8")
    
    return @app.call(env) unless req.path.match(/metrics/)

    require 'pry'
    binding.pry
    
    if allowed_networks===IPAddr.new(req.ip)
      @app.call(env)
    else
      [ 401, { "Content-Type" => "text/plain" }, ["401: unauthorized\n"] ]
    end
  end
end