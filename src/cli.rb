require "optparse"
module Spider
  module CLI
    class Options
      class << self
        attr_accessor :options

        def parse(argv)

        end
      end
      @options = {
        # timeout when retriving a web page, 5 sec default
        :timeout => 5,
        # how many process run in parallel
        :concurrent => 1,
        # office data or rent data
        :office_data_only => false
      }

    end

    def run!
      puts ARGV
      options = Options.parse ARGV
      
    end

    def usage
      $stdout.puts " Spider - a tool to spider office & office rent info around China"
      $spider.puts "./spider [OPTIONS]"
      $spider.puts ""
      $spider.puts " --timeout=10        how long it will take to kill itself before a request fail to get response"
      $spider.puts " --concurrent=10     how many processes run in parallel to fetch data"
      $spider.puts " --office-data-only  retrive only office data"
    end

    module_function :run!
  end
end
