# -*- encoding : utf-8 -*-

require "httparty"
class Crawler
  include HTTParty

  cattr_accessor :headers
  @@headers = {
    "Content-Type" => "text/html",
    "Referer" => "https://www.google.com/",
    "User-Agent" => "User-Agent:Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36"
  }

  def get(url, options = {})
    headers = @@headers.merge(options[:headers] || {})
    self.class.get(url, :headers => headers)
  end
end
