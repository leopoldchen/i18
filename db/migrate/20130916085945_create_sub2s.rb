class CreateSub2s < ActiveRecord::Migration
  def change
    create_table :sub2s do |t|
      t.string :name

      t.timestamps
    end
  end
end
