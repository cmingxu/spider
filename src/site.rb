# -*- encoding : utf-8 -*-
class Site
  attr_accessor :name, :url, :identity

  def initialize(identity, name, url)
    self.name = name
    self.identity = identity
    self.url = url
  end
end
