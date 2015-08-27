class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :continent
      t.integer :state
      t.string :city
      t.string :coordinate

      t.timestamps null: false
    end
    add_index :locations, :city, unique: true
  end
end
