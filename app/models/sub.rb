class Sub < ActiveRecord::Base
  attr_accessible :name
  require "module/i18"
	extend I18n
	db_i18n(:name,[:en,:zh,:jp])
end
