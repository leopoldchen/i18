class AddAttributesToGos < ActiveRecord::Migration
  def change
    add_column :gos, :classid, :integer
    add_column :gos, :classname, :string
    add_column :gos, :property, :string
    add_column :gos, :jsoncontent, :text
  end
end
