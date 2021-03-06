# -*- encoding : utf-8 -*-
## actual runner of the spider
#

require "records"
require "spider_config"
require "crawler"
require "awesome_print"
require "sites/fang_xun/base"
require "sites/fang_xun/price"

require "sites/soufun/base"
require "sites/soufun/price"

require "sites/china_office/base"
require "sites/china_office/price"

require "sites/focus/base"
require "sites/focus/price"

class Worker
  def initialize(opt)
    ActiveRecord::Base.logger = SpiderConfig.log
    ActiveRecord::Base.establish_connection(SpiderConfig.db_spec)
    ActiveRecord::Base.connection.execute "SET NAMES utf8;"
  end

  def run
    
    #require "web"
    #FangXun::Base.new.craw
    #Focus::Base.new.craw
    Focus::Price.new.craw
    #FangXun::Price.new.craw
    
    #Soufun::Base.new.craw
    #Soufun::Price.new.craw
    
    #ChinaOffice::Base.new.craw
    #ChinaOffice::Price.new.craw
  end
end
