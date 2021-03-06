class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper
  include LocationsHelper
  include ApplicationHelper
  include LogsHelper

private

  def logged_in_user
		unless logged_in?
        flash[:danger] = "You must be logged in for this action."
        redirect_to login_url
    end
  end

   def admin_user
      if !current_user.nil?
        redirect_to(root_url) unless current_user.admin?
      else
        redirect_to(root_url)
      end
    end


    
end
