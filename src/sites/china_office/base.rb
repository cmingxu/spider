# -*- encoding : utf-8 -*-
require "crawler"
require "nokogiri"

module ChinaOffice
  class Base
    def craw
      text = Crawler.new.get "http://beijing.chineseoffice.com.cn/RentOffice/index.aspx"

      doc = Nokogiri::HTML(text)
      biggest_page = Integer(doc.css("form#form1 div.main div#pager_pagerDiv span.count").text.scan(/\d+/).first)

      (1..biggest_page).each do |page|
       office_by_page( "http://beijing.chineseoffice.com.cn/RentOffice/index.aspx?page=#{page}")
      end
    end

    def office_by_page(link)
      SpiderConfig.log.debug link
      text = Crawler.new.get link
      doc = Nokogiri::HTML(text)
      doc.css("form#form1 div.main div.leftcon div#officelist li.l0 input").each do |office|
        office_node = OpenStruct.new
        office_node.name = office['onclick'].split(" ")[1].strip[1..-3]
        if s = office['onclick'].split(" ")[2]
          office_node.href = s.strip[1..-3]
          office_info_scrap(office_node)
        end
      end
    end

    def office_info_scrap(office_node)
      SpiderConfig.log.debug office_node.href
      text = Crawler.new.get office_node.href
      doc = Nokogiri::HTML(text, nil, "gbk")

      o = Office.find_by_name_and_source_site(office_node.name, "chinaoffice") || Office.new
      o.name = office_node.name
      o.link = office_node.href
      o.source_site = "chinaoffice"
      detail_info = doc.css("div.main div.detail_info ul li")
      o.area_name = detail_info[1].text.split(SpiderConfig.sep).last
      o.wuye_name = detail_info[6].text.split(SpiderConfig.sep).last
      o.kaifashang = detail_info[7].text.split(SpiderConfig.sep).last
      o.address = detail_info[8].text.split(SpiderConfig.sep).last.split("(").first
      o.wuyefei = detail_info[5].css("div").text.split(SpiderConfig.sep).last
      o.mianji = detail_info[4].css("div").text.split(SpiderConfig.sep).last

      detail_info2 = doc.css("div.main div.detail_info ul")[1]
      o.contact = detail_info2.css('li.tel strong').text

      o.save
    end
  end
end
