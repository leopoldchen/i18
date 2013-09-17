class AddNameToSub.rb < ActiveRecord::Migration
  def change
    add_column :subs, :name, :string
  end
end
