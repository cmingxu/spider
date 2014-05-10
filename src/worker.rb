# -*- encoding : utf-8 -*-
## actual runner of the spider
#

require "records"
require "spider_config"
require "crawler"
require "awesome_print"
require "sites/fang_xun/base"
require "sites/soufang/base"
require "sites/fang_xun/price"

class Worker
  def initialize(opt)
    ActiveRecord::Base.logger = SpiderConfig.log
    ActiveRecord::Base.establish_connection(SpiderConfig.db_spec)
    ActiveRecord::Base.connection.execute "SET NAMES utf8;"
  end

  def run
    #FangXun::Base.new.craw
    #FangXun::Price.new.craw
    #
    
    Soufang::Base.new.craw
  end
end
