# -*- encoding : utf-8 -*-
require "crawler"
require "nokogiri"

module Soufun
  class Base
    def craw
      text = Crawler.new.get "http://office.soufun.com/loupan/house/i31/"

      doc = Nokogiri::HTML(text)
      biggest_page = doc.css("div#wrap div.main.mt10 ul.mt10 li.pages.floatr #PageControl1_hlk_last").first["href"].grep(/\d+/)
      ap biggest_page

    end
  end
end
