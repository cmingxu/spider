# -*- encoding : utf-8 -*-
require "crawler"
require "nokogiri"

module FangXun
  class Base
    def craw
      text = Crawler.new.get "http://www.funxun.com/fczy/chaoyang.asp"

      doc = Nokogiri::HTML(text)
      #areas = doc.css("html body div.fun div.me a")

      #areas.each do |area|
        #puts area.content.encode("utf-8")
        #puts area["href"]
      #end

      #biggest_page = doc.search("html body div.fun div div.officelist form")
      #puts biggest_page
      biggest_page = doc.css("ul li.aa span.info div.info_1 a").each do |a|
      puts biggest_page
      puts a.content

      end
      #biggest_page = doc.css("html body div.fun div.officelist ul li.pagejum form#jumpform")
      #puts biggest_page
      #biggest_page = doc.css("html body #jumpform font")
      #puts biggest_page.content

    end
  end
end
