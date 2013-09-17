module I18n
	require "json"
	# require "go"
	def db_i18n(method, *args)
		# include Del
		args[0].each do |language|
		# if /(^\w+)_([a-z]+)/.match(method)
			# attribute = $1
			# language = $2
				# if  /=/.match(method)
					new_method = method.to_s+"_"+language.to_s+"="
					new_method = new_method.to_sym
					# self.class.send :define_method, new_method do |args| #set_value
					self.send :define_method, new_method do |args| #set_value
				    	# puts "call:#{method} #{args}"
				    	# eval("self.save(:record => {:#{attributes}=>\"#{language}\"})")
				    	@s_result = Go.new if (@s_result = Go.where(:classid => self.id, :classname => self.class.name, :property => method.to_s).first).blank?
				    	@count = 0
				    	result = "" if @s_result.jsoncontent.blank?
				    	result = @s_result.jsoncontent if !@s_result.jsoncontent.blank?
				    	arr = result.split(",")
				    	arr.each do |str|
				    			json=JSON.parse(str)
				    			arr.delete_at(@count) if !json["#{language}"].blank?
				    			@count += 1
				    		end
		    			arr.push("{\"#{language}\":\"#{args}\"},")
		    			str = arr.join(",")
				    	# self.record = "{\"#{attribute}\":{\"#{language}\":\"#{args}\"}},"
				    	@s_result.classid = self.id#obj.id 
				    	@s_result.classname = self.class.name #obj.class.name
				    	@s_result.property = method.to_s
				    	@s_result.jsoncontent = str
				    	@s_result.save
				    end
				    # self.send(method, args[0])
				# else
						new_method = method.to_s+"_"+language.to_s
						new_method = new_method.to_sym
				    # self.class.send :define_method, new_method do #get_value
				      self.send :define_method, new_method do #get_value
				    	# puts "call:get#{method}"
					    	if !(@s_result = Go.where(:classid => self.id, :classname => self.class.name, :property => method.to_s).first).blank?
						    	return @var if (@s_result.jsoncontent).blank?
						    	arr = (@s_result.jsoncontent).split(",")
						    	arr.each do |str|
						    		str = str.to_s
						    		json = JSON.parse(str)
						    		if !json["#{language}"].blank?
						    			@var = json["#{language}"]
						    			break
						    		end
						    	end
						    	return @var
								else
								 	return ""
								end
					    end
				    # self.send method
				    # delete_method = "delete"
				    # 	self.send :define_method, delete_method do
				    # 		if !(@s_result = Go.where(:classid => self.id, :classname => self.class.name)).blank?
				    # 			@s_result.each do |result|
				    # 				result.delete
				    # 			end
				    # 		end
				    # 		self.delete
				    # 	end
			 	 # end

			# else
			# 		super
		  # end
		end
			self.send :define_method, method do #get_value_with_i18n.locale
	    	locale = I18n.locale.to_s
	    		self.send  method.to_s+"_"+locale
	    end
	end
end
module Del
	def delete
		if !(@s_result = Go.where(:classid => self.id, :classname => self.class.name)).blank?
			@s_result.each do |result|
				result.delete
			end
		end
		super
	end
end