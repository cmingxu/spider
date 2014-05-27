


require 'sinatra/base'
my_app = Sinatra.new do 
  set :root, File.dirname(__FILE__)
  set :public_folder, 'public'
  set :views, Proc.new { File.join(root, "templates") }
  get('/') { "hi" } 
end
my_app.run!
