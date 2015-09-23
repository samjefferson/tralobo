module LogsHelper

	def hot_logs
		Log.where(created_at: ( Time.now - 24.hours )..Time.now).reorder('cached_votes_score DESC').first(5)
	end

end
