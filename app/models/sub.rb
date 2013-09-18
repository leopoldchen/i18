class Sub < ActiveRecord::Base
  attr_accessible :name
  attr_accessor :name_map, :des_map
  require "module/i18"
	extend I18n
	db_i18n(:name,[:en,:zh])
	db_i18n(:des,[:en,:zh])
end
