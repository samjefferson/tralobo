class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true
      t.references :location, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :logs, [:user_id, :created_at]
    add_index :logs, [:location_id, :created_at]
  end
end
