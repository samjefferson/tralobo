module LogsHelper

	def hot_logs
		if Log.exists?
			Log.where(created_at: ( Time.now - 24.hours )..Time.now).reorder('cached_votes_score DESC').first(5)
		end
	end

	def latest_log
		if Log.exists?
			Log.all.reorder('created_at DESC').first
		end
	end

	

end
