class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.ci_find('username', params[:session][:username])
  	if !user.is_a?(User::ActiveRecord_Relation)
  		if user.authenticate(params[:session][:password])
  			log_in user
  			remember user
  			redirect_to user
  		else
 				invalid
 			end
 		else
 			invalid
  	end
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_url 
  end


  private

  	def invalid
  		flash.now[:danger] = 'Invalid username or password'
  		render 'new'
  	end
end
