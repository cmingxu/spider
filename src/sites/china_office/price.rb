# -*- encoding : utf-8 -*-
module ChinaOffice
  class Price
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
      doc.css("form#form1 div.main div.leftcon div#officelist ul").each do |office|
        ap office.css("li.l0").text
        ap office.css("li.l1 li span")[1].text
      end
    end
  end
end
