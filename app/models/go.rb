class Go < ActiveRecord::Base
  attr_accessible :classid, :classname, :property, :jsoncontent
  attr_accessor :property_map
end
