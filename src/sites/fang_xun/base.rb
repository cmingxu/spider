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
        #Area.find_or_create_by_name(a.text)
        office_by_area(a["href"])
      end
    end

    private

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
        office_info_scrap(office)
      end
    end

    def office_info_scrap(office_node)

      link = "http://www.funxun.com/fczy/" + office_node["href"]
      html = Crawler.new.get link
      doc = Nokogiri::HTML(html, nil, "gbk")

      o = Office.find_by_name(office_node.text) || Office.new
      o.name = office_node.text
      o.link = link
      o.source_site = "fangxun"
      o.tel = doc.css("p.tel span.tel4 strong").text
      # address
      o.address = doc.css("div.fou div div.baseinfo p")[1].try(:text)
      o.address = o.address.split(" ")[0] if o.address
      o.address = o.address.split("：")[1] if o.address
      # detail 
      info = doc.css("div.fou div div.newsinfo2013")[1]
      if info
        o.kaifashang = info.css("ul li.newsinfo2013cont")[0].try(:text)
        o.wuye_name  = info.css("ul li.newsinfo2013cont")[1].try(:text)
        o.wuyefei    = info.css("ul")[1].css("li.newsinfo2013cont")[0].try(:text)
      end

      info = doc.css("div.fou div div.newsinfo2013")[0]
      if info
        o.area_name  = info.css("ul li.newsinfo2013cont")[0].try(:text)
        o.shangquan  = info.css("ul li.newsinfo2013cont")[1].try(:text)
      end

      o.detail = []
      doc.css("div.fou div div.newsinfo2013").each do |section|
        pair = {}
        section.css("ul li.newsinfo2013biaoti").each_with_index do |k, i|
          pair[k.text] = section.css("ul li.newsinfo2013cont")[i].try(:text)
        end
        o.detail << pair
      end

      o.save
    rescue Exception => e
      SpiderConfig.log.error e
    end
  end
end
