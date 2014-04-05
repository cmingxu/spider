$LOAD_PATH.push File.dirname(__FILE__) + "/src"

require "cli"

Spider::CLI.run!
