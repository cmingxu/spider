# -*- encoding : utf-8 -*-
class Site
  attr_accessor :name, :url, :identity

  def initialize(identity, url, name)
    self.name = name
    self.identity = identity
    self.url = url
  end
end
