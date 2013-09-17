require "spec_helper"

describe I18n do
	describe "i18n_test" do
		context "when model isn't extend I18n" do
			before(:each) do
				@s = Sub2.create
				@s.name = "nomal"
			end

			it "should @s.name is @s.name " do
					(@s.name == "nomal").should be_true
			end
			
			it "should @s.name_en isn't exist " do
				(!@s.methods.include? "name_en").should be_true
			end

			it "should @s.name_zh isn't exist " do
				(!@s.methods.include? "name_zh").should be_true
			end
		end

		context "when model extend I18n" do
			before(:each) do

				Sub.class_eval do
					require "module/i18"
					extend I18n
					db_i18n(:name,[:en,:zh,:jp])
				end

				@s = Sub.crea
				@s.name_en = "hello"
				@s.name_zh = "你好"
			end

			it "should @s.name is equal @s.name_en when I18n.locale is :en " do
				I18n.locale = :en
				(@s.name == "hello").should be_true
			end
			
			it "should @s.name is equal @s.name_zh when I18n.locale is :zh " do
				I18n.locale = :zh
				(@s.name == "你好").should be_true
			end

			it "should @s.name is equal @s.name_jp when I18n.locale is :jp " do
				I18n.locale = :jp
				(@s.name_jp == "").should be_true
			end

			it "should Sub.property in Go.property" do
				id = @s.id
				class_name = @s.class.name
				property = "name"
				text = "{\"en\":\"hello\"},{\"zh\":\"你好\"},"
				(Go.where(:id => id, :classname => class_name, :property => property, :jsoncontent => text ).blank?).should be_false
				(@s.id == 1) .should be_true
			end

			it "when @s is delete" do
				id = @s.id
				class_name = @s.name
				@s.delete
				Go.where(:id => id, :classname => class_name).blank? .should be_true
			end

		end

	end
end
