class Notification < ActiveRecord::Base
	#notifications will be produced when a user comments on a log and 
	#and sent to everyone that has already commented and the owner of the log

	belongs_to :user
	belongs_to :log
	
end
