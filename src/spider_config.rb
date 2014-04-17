# -*- encoding : utf-8 -*-
module SpiderConfig
  class << self
    def db_spec
      {
        :adapter => :mysql2,
        :host => "localhost",
        :port => 3306,
        :username => "root",
        :password => "",
        :database => "crawler"
      }
    end

    def pro?
      (ENV["CRAWLER_ENV"] || "").downcase == "pro"
    end

    def log
      Logger.new(self.pro? ? File.open(SpiderRoot.to_s + "/tmp/debug.log", "w") : STDOUT)
    end

    def sites
      [
        Site.new("fangxun", "http://www.funxun.com/", "房讯网"),
        Site.new("chinaoffice", "http://beijing.chineseoffice.com.cn/", "中国写字楼"),
        Site.new("soufang", "http://office.soufun.com/", "搜房写字楼频道")
      ]
    end

  end
end
