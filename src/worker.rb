## actual runner of the spider
#

require "records"
require "spider_config"
require "crawler"
require "awesome_print"

class Worker
  def initialize(opt)
    ActiveRecord::Base.logger = SpiderConfig.log
    ActiveRecord::Base.establish_connection(SpiderConfig.db_spec)
  end

  def run
    res =  Crawler.new.get "http://www.funxun.com/fczy/office/107691_2.html"
    File.open SpiderConfig.html_file_path.to_s + "/a.html", "w+" do |f|
      f << res.body
    end
  end
end
