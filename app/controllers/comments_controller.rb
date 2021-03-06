class CommentsController < ApplicationController
	before_action :logged_in_user, only: :create
	before_action :admin_user, only: [:destroy, :update]

	def show
		@comment = Comment.find(params[:id])
	end

	def create
		@comment = current_user.comments.build(comment_params)

		if @comment.save
    flash[:success] = "Log created"
    redirect_to @comment.log
  else
  	flash[:danger] = "Error, please try again!"
  	redirect_to :back
  end
	end

	def destroy
		Comment.find(params[:id]).destroy
		flash[:success] = "Comment deleted"
		redirect_to request.referrer || root_url
	end

	def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      flash[:success] = "Comment censored."
      redirect_to @comment.log
    end
  end


	private

		def comment_params
			params.require(:comment).permit(:log_id, :content)
		end
end
