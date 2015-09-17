class LogsController < ApplicationController

include SessionsHelper
before_action :logged_in_user, only: [:new, :create, :destroy, :upvote, :downvote, :unvote]
before_action :admin_user, only: :destroy

def show
	@log = Log.find(params[:id])
	@comments = @log.comments.paginate( page: params[:page], per_page: 10)
	@comment = current_user.comments.build if logged_in?

	@upvoted = current_user.voted_up_on? @log if !current_user.nil?
	@downvoted = current_user.voted_down_on? @log if !current_user.nil?
end

def new
end


def create
	@log = current_user.logs.build(log_params)

	if @log.save
    flash[:success] = "Log created"
    redirect_to @log.location
  else
  	flash[:danger] = "Error, please try again!"
  	redirect_to :back
  end
end

def destroy
	Log.find(params[:id]).destroy
   flash[:success] = "Log deleted"
    redirect_to root_path
end

def upvote
	@log = Log.find(params[:id])
	@log.upvote_by current_user
	redirect_to @log
end

def downvote
	@log = Log.find(params[:id])
	@log.downvote_by current_user
	redirect_to @log
end

def unvote
	@log = Log.find(params[:id])
	@log.unvote_by current_user
	redirect_to @log
end

private
	
	def log_params
		params.require(:log).permit(:title, :content, :location_id)
	end

end
