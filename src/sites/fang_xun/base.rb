require "crawler"
require "nokogiri"

module FangXun
  class Base
    def craw
      index = Crawler.new.get "http://www.funxun.com/fczy/chaoyang.asp"

      Nokogiri::HTML(index)

    end
  end
end
