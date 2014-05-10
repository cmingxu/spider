# -*- encoding : utf-8 -*-
require "crawler"
require "nokogiri"

module Soufang
  class Base
    def craw
      1000.times do |i|
        text = Crawler.new.get "http://office.soufun.com/loupan/house/i31/"
        SpiderConfig.log.debug i
      end

      #doc = Nokogiri::HTML(text)
      #areas = doc.css("html body div.fun div.me a")

      #areas.each do |area|
        #puts area.content.encode("utf-8")
        #puts area["href"]
      #end
      #biggest_page = doc.css("html body #jumpform font")
      #puts biggest_page.content

    end
  end
end
