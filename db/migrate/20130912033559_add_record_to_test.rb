class AddRecordToTest < ActiveRecord::Migration
  def change
    add_column :tests, :record, :text
  end
end
