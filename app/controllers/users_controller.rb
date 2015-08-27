class UsersController < ApplicationController
  before_action :admin_user,     only: :destroy

  def show
  	@user = User.find(params[:id])
    if !current_user.nil?

      unless current_user?(@user) || current_user.admin? 
        redirect_to root_path
      end
    else
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

  def edit
    @user = User.find(params[:id])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_url
  end

  private
  	def user_params
  		params.require(:user).permit(:username, :email, :password, :password_confirmation)
  	end

    def admin_user
      if !current_user.nil?
        redirect_to(root_url) unless current_user.admin?
      else
        redirect_to(root_url)
      end
    end
end
