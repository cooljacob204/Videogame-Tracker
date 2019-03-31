root = ::File.dirname(__FILE__)
require ::File.join( root, 'app' )
Dir[File.join(File.dirname(__FILE__), "app/controllers", "*.rb")].each {|f| require f}
use ApplicationController
use SessionsController
run MyApp.new