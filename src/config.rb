module Config
  class << self
    def db_spec
      {
        :adapter => :mysql2,
        :host => "localhost",
        :port => 3306,
        :username => "root",
        :password => ""
      }
    end

    def sites
    end

  end
end
