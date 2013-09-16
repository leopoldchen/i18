class CreateGos < ActiveRecord::Migration
  def change
    create_table :gos do |t|

      t.timestamps
    end
  end
end
