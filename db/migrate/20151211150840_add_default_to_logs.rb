class AddDefaultToLogs < ActiveRecord::Migration
  def change
  	change_column :logs, :cached_votes_score, :integer, default: 0
  end
end
