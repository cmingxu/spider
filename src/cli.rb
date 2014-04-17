# -*- encoding : utf-8 -*-
require "optparse"
require "worker"

module Spider
  module CLI
    class Options
      class << self
        attr_accessor :options

        def parse(argv)
          OptionParser.new do |opts|
            opts.on( "-t", "--timeout T", Integer,
                    "How long it will take to timeout a request.") do |opt|
              @options[:timeout] = opt
            end

            opts.on( "-c", "--concurrent C", Integer,
                    "How many concurrent processes.") do |opt|
              @options[:concurrent] = opt
            end
          end.parse! argv
        end
      end
      self.options = {
        # timeout when retriving a web page, 5 sec default
        :timeout => 5,
        # how many process run in parallel
        :concurrent => 1,
        # office data or rent data
        :office_data_only => false
      }

    end

    def run!
      Options.parse ARGV
      Worker.new(Options.options).run
    end

    module_function :run!
  end
end
