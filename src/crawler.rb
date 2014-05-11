# -*- encoding : utf-8 -*-

require "httparty"
class Crawler
  include HTTParty

  cattr_accessor :headers
  @@headers = {
    "Content-Type" => "text/html",
    "Referer" => "https://www.google.com/",
    "User-Agent" => "Sogou web spider/4.0"
  }

  def get(url, options = {})
    headers = @@headers.merge(options[:headers] || {})
    begin
      self.class.get(url, :headers => headers)
    rescue Errno::ETIMEDOUT => e
      puts e
      sleep 60
      retry
    rescue Errno::ECONNREFUSED => e
      puts e
      sleep 60
      retry
    end
  end
end
