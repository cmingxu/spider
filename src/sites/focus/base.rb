# -*- encoding : utf-8 -*-
require "crawler"
require "nokogiri"

module Focus
  class Base
    def craw
      text = Crawler.new.get "http://office.focus.cn/park/search.php"

      doc = Nokogiri::HTML(text)
      ap doc.css(".area.contA .listBox .right")
      biggest_page = Integer(doc.css("body > div.area.contA > div.l > div.listBox > div > div.right a").last["href"].scan(/\d+/)[0])

      (1..biggest_page).each do |page|
        puts page
       #office_by_page( "http://office.soufun.com/loupan/house/i3#{page}/")
        
      end
    end


    def office_by_page(link)
      SpiderConfig.log.debug link
      text = Crawler.new.get link
      doc = Nokogiri::HTML(text)
      doc.css("div#wrap div.main.mt10 dt p.housetitle a").each do |office|
        SpiderConfig.log.debug office.css("strong").text
        office_info_scrap(office)
      end
    end

    def office_info_scrap(office_node)
      SpiderConfig.log.debug office_node['href']
      text = Crawler.new.get office_node['href']
      doc = Nokogiri::HTML(text, nil, "gbk")

      o = Office.find_by_name_and_source_site(office_node.text, "soufun") || Office.new
      o.name = office_node.text
      o.link = office_node['href']
      o.source_site = "soufun"
      address_info = doc.css("div#wrap div.wrap.mt10 span.gray6")
      address_info = address_info.css("span").text
      address_info = address_info.split(" ")
      o.address = address_info[2]
      o.area_name = address_info[0][1..-1]
      o.shangquan = address_info[1].chomp("]")

      o.wuye_name = doc.css("div#wrap div.wrap.mt10 div.xiangqing dl dt").text.split("：")[1]
      o.wuyefei = doc.css("div#wrap div.wrap.mt10 div.xiangqing dl dd")[2].text.split("：")[1]
      o.mianji = doc.css("div#wrap div.wrap.mt10 div.xiangqing dl dd")[3].text.split("：")[1]
      o.zhuangxiu = doc.css("div#wrap div.lpblbox1 dl.xiangqing dd")[6].text.split("：")[1]
      o.kaifashang = doc.css("div#wrap div.lpblbox1 dl.xiangqing dd")[10].text.split("：")[1]

      o.detail =  []
      doc.css("div#wrap div.wrap.mt10 div.xiangqing dl dd").each do |node|
        str = node.text
        hash = {}  
        hash[str.split(SpiderConfig.sep)[0]] = str.split(SpiderConfig.sep)[1]
        o.detail << hash
      end

      doc.css("div#wrap div.lpblbox1 dl.xiangqing dd").each do |node|
        str = node.text
        hash = {}  
        hash[str.split(SpiderConfig.sep)[0]] = str.split(SpiderConfig.sep)[1]
        o.detail << hash
      end

      o.save
    end
  end
end
