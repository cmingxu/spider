require 'sinatra/base'
require "daemons"
require 'sinatra/twitter-bootstrap'
require "sinatra/reloader" 
require "spider_config"
require 'sinatra/base'
require 'sinatra/paginate'

PAGE_SIZE = 20


my_app = Sinatra.new do
  set :root, File.dirname(__FILE__)
  set :public_folder, File.join(root, 'templates/public')
  set :views, Proc.new { File.join(root, "templates") }

  get('/') { haml :index }
  get('/offices') do
    @sites = SpiderConfig.sites
    @offices = Office.limit(PAGE_SIZE).offset(page * PAGE_SIZE)
    haml :offices
  end 

  register Sinatra::Twitter::Bootstrap::Assets

  configure :development do
    register Sinatra::Reloader
  end

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
      
      def active_if_possible(path)
        request.path == path ? "active" : ""
      end
    def page
      [params[:page].to_i - 1, 0].max
    end
      
  end

end

my_app.run!

