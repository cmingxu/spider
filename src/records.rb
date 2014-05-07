# -*- encoding : utf-8 -*-

require "active_record"

class Area < ActiveRecord::Base
  has_many :circles
  has_many :offices
end

class Circle < ActiveRecord::Base
  belongs_to :area
  has_many :offices
end

class Office < ActiveRecord::Base
  belongs_to :circle
  belongs_to :area
  has_many :rents

  serialize :detail
end

class Rent < ActiveRecord::Base
  belongs_to :offices
end
