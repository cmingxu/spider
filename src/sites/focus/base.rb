# -*- encoding : utf-8 -*-
require "crawler"
require "nokogiri"

module Focus
  class Base
    def craw
      biggest_page = 31

      (1..biggest_page).each do |page|
       office_by_page( "http://office.focus.cn/park/search.php?page=#{page}")
      end
    end


    def office_by_page(link)
      SpiderConfig.log.debug link
      text = Crawler.new.get link
      doc = Nokogiri::HTML(text)
      doc.css("body div.area.contA div.l div.listBox ul div.t a").each do |office|
        SpiderConfig.log.debug office.text

        office_info_scrap(office)
      end
    end

    def office_info_scrap(office_node)
      link = "http://office.focus.cn" + office_node['href'].sub(/(\d+)/, 'details_\1')
      SpiderConfig.log.debug link
      
      text = Crawler.new.get(link)
      ap text
      doc = Nokogiri::HTML(text, nil)

      o = Office.find_by_name_and_source_site(office_node.text, "focus") || Office.new
      o.name = office_node.text
      o.link = link
      o.source_site = "focus"

      address_info = doc.css("div.area.cutC div.l div.blockLA div.bg div.boxA div.txt")
      o.address   = address_info.css('li')[9].text if address_info.css('li')[9]
      o.area_name = address_info.css('li')[3].text if address_info.css('li')[3]
      o.shangquan = address_info.css('li')[7].text if address_info.css('li')[7]

      if wuye_block =  doc.css("div.area.cutC div.l div.blockLA div.bg div.boxA div.txt")[4]
        o.wuye_name  = wuye_block.css("li")[1].text
      end

      o.detail =  []
      hash = {}
      doc.css("div.area.cutC div.l div.blockLA div.bg div.boxA div.txt").each do |node|
        node.css("li").each_slice(2) do |es|
          hash[es[0].text] = es[1].text
        end
      end
      o.detail << hash
      o.save
    end
  end
end
