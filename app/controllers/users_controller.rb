class UsersController < ApplicationController
  
  def show
  	@user = User.find(params[:id])
    if !@user = current_user
      redirect_to root_path
    end
  end


  def new
  	@user = User.new
  end

  def create
  	@user = User.create(user_params)
  	if @user.save
      log_in @user
  		flash[:success] = "Sign Up Successful"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  private
  	def user_params
  		params.require(:user).permit(:username, :email, :password, :password_confirmation)
  	end
end
