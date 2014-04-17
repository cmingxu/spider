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
    ap Crawler.get "http://www.funxun.com/fczy/office/107691_2.html"
  end
end
