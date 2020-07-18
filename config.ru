root = ::File.dirname(__FILE__)
require ::File.join(root, 'app')
Dir[File.join(File.dirname(__FILE__), 'app/controllers', '*.rb')].each { |f| require f }
Dir[File.join(File.dirname(__FILE__), 'app/middlewares', '*.rb')].each { |f| require f }
use Rack::Deflater
use Rack::MethodOverride
use Prometheus::Middleware::Collector
use MediaValidation
use Prometheus::Middleware::Exporter
use GamesController
use LibraryController
use UsersController
run ApplicationController.new
