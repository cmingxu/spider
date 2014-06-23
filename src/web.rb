require 'sinatra/base'
require "daemons"
require 'sinatra/twitter-bootstrap'


my_app = Sinatra.new do
  set :root, File.dirname(__FILE__)
  set :public_folder, File.join(root, 'templates/public')
  set :views, Proc.new { File.join(root, "templates") }
  get('/') { haml :index }

  get('/offices') { haml :offices }

  register Sinatra::Twitter::Bootstrap::Assets

  helpers do
      def css(css_file)
        "<link rel='stylesheet' href='/stylesheets/#{css_file}' type='text/css' media='screen, projection'>"
      end

      def image(image_file)
        "<img src='/images/#{image_file}' alt=''>"
      end

      def js(js_file)
        "<script type='text/javascript'>/javascripts/#{js_file}</script>"
      end
  end
end
my_app.run!

