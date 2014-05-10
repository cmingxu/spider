# -*- encoding : utf-8 -*-
require "crawler"
require "nokogiri"

module Soufun
  class Base
    def craw
      text = Crawler.new.get "http://office.soufun.com/loupan/house/i31/"

      doc = Nokogiri::HTML(text)
      biggest_page = Integer(doc.css("div#wrap div.main.mt10 ul.mt10 li.pages.floatr #PageControl1_hlk_last").first["href"].scan(/3(\d+)/).flatten.first)

      (1..biggest_page).each do |page|
        craw_by_page( "http://office.soufun.com/loupan/house/i3#{page}/")
      end
    end


    def craw_by_page(link)
      ap link
      text = Crawler.new.get link
      doc = Nokogiri::HTML(text)
      doc.css("div#wrap div.main.mt10 dt p.housetitle a").each do |page|
        ap page['href']
        ap page.css("strong").text

        craw_by_office(page)
      end
    end

    def craw_by_office(page)
    end
  end
end
