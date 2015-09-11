class LogsController < ApplicationController

before_action :logged_in_user, only: [:new, :create, :destroy]
before_action :admin_user, only: :destroy

def show
	@log = Log.find(params[:id])
	@comments = @log.comments.paginate( page: params[:page], per_page: 10)
	@comment = current_user.comments.build if logged_in?
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

private
	
	def log_params
		params.require(:log).permit(:title, :content, :location_id)
	end

end
