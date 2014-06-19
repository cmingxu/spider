require 'sinatra/base'
require "daemons"

my_app = Sinatra.new do
  set :root, File.dirname(__FILE__)
  set :public_folder, 'public'
  set :views, Proc.new { File.join(root, "templates") }
  get('/') { haml :index }

end
my_app.run!
Daemons.daemonize!

