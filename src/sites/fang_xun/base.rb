# -*- encoding : utf-8 -*-
require "crawler"
require "nokogiri"

module FangXun
  class Base
    def craw
      text = Crawler.new.get "http://www.funxun.com/fczy/chaoyang.asp"
      doc = Nokogiri::HTML(text, nil, "gbk")
      doc.css("div.fun div.me a").each do |a|
        SpiderConfig.log.debug a.text
        office_by_area(a["href"])
      end

    end

    def office_by_area(link)
      SpiderConfig.log.debug link
      text = Crawler.new.get link
      doc = Nokogiri::HTML(text, nil, "gbk")
      biggest_page = doc.css("form#jumpform font:first")
      SpiderConfig.log.debug biggest_page.text

      1.upto(Integer(biggest_page.text)).each do |p|
        office_by_page(link + "?Page=" + p.to_s)
      end
    end

    def office_by_page(link)
      SpiderConfig.log.debug link
      html = Crawler.new.get link

      doc = Nokogiri::HTML(html, nil, "gbk")
      doc.css("li.aa div.info_1 a").each do |office|
          SpiderConfig.log.debug office.text
          SpiderConfig.log.debug office["href"]
      end

    end
  end
end
