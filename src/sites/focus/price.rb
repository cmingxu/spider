# -*- encoding : utf-8 -*-
module Focus
  class Price
    def craw
      text = Crawler.new.get "http://office.soufun.com/loupan/house/i31/"

      doc = Nokogiri::HTML(text)
      biggest_page = Integer(doc.css("div#wrap div.main.mt10 ul.mt10 li.pages.floatr #PageControl1_hlk_last").first["href"].scan(/3(\d+)/).flatten.first)

      (1..biggest_page).each do |page|
        office_by_page( "http://office.soufun.com/loupan/house/i3#{page}/")

      end
    end


    def office_by_page(link)
      SpiderConfig.log.debug link
      text = Crawler.new.get link
      doc = Nokogiri::HTML(text)
      doc.css("div#wrap div.main.mt10 div.esflist div.house").each do |node|
        office = node.css("dl dt p.housetitle a")
        SpiderConfig.log.debug office.css("strong").text

        office_in_db = Office.find_by_name_and_source_site(office.css("strong").text, "soufun")
        SpiderConfig.log.error "[#{office.css('strong').text} NOT FOUND IN DB]"

        Rent.new do |rent|
          rent.office_id = office_in_db.id
          rent.buy_price = node.css("dl dd.office_lp strong.orange")[0].text
          rent.price = node.css("dl dd.office_lp strong.orange")[1].text
          rent.office_name = office_in_db.name
          rent.source_site = "soufun"
        end.save

      end
    end

  end
end
