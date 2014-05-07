# -*- encoding : utf-8 -*-
module FangXun
  class Price

    def craw
      Office.where("source_site='fangxun'").find_each(batch_size: 10) do |office|
        text = Crawler.new.get office.link
        doc = Nokogiri::HTML(text, nil, "gbk")
        price =  doc.css("div.fou div div.baseinfo p")[3].css("span strong").text
        Rent.create do |r|
          r.price = price
          r.created_at = Time.now
          r.source_site = 'fangxun'
          r.office_id = office.id
          r.office_name = office.name
        end
      end
    end
  end
end
