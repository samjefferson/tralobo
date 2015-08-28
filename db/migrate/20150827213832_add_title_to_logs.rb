class AddTitleToLogs < ActiveRecord::Migration
  def change
  	add_column :logs, :title, :string
  end
end
