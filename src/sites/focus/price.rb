# -*- encoding : utf-8 -*-
require "crawler"
require "nokogiri"

module Focus
  class Price
    def craw
      biggest_page = 31

      (1..biggest_page).each do |page|
        link = "http://office.focus.cn/park/search.php?page=#{page}"
        SpiderConfig.log.debug link
        text = Crawler.new.get link
        doc = Nokogiri::HTML(text)
        doc.css("body div.area.contA div.l div.listBox ul li").each do |office|
          office_name = office.css("div.t a").text
          price       = office.css("div.price").text
          SpiderConfig.log.debug office_name
          SpiderConfig.log.debug price

          if office = Office.find_by_source_site_and_name("focus", office_name)
            Rent.new do |rent|
              rent.office_id = office.id
              rent.price = price
              rent.office_name = office_name
              rent.source_site = "focus"
            end.save
          end
        end
      end
    end
  end
end
