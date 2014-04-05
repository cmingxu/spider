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
        :processes => 1
      }

    end

    def run!
      puts ARGV
    end

    def usage
      $stdout.puts 
    end

    module_function :run!
  end
end
