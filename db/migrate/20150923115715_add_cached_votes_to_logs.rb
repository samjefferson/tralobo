class AddCachedVotesToLogs < ActiveRecord::Migration
  def self.up
  	add_column :logs, :cached_votes_total, :integer, default: 0
  	add_column :logs, :cached_votes_score, :integer, default: 0
  	add_index :logs, :cached_votes_score

  end

  def self.down 
  	remove_column :logs, :cached_votes_total
  end

end
