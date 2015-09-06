class LocationsController < ApplicationController

before_action :admin_user,     only: :destroy
  def new
  	redirect_to root_url unless logged_in?
  	@location = Location.new
  end

  def create
  	@location = Location.create(location_params)
  	if @location.save
  		redirect_to root_url #will change this later
  		flash[:success] = 'Entry successful'
  	else
  		render 'new'
  	end
  end

  def show
    @location = Location.find(params[:id])
    @logs = @location.logs.paginate(page: params[:page])
    @log = current_user.logs.build if logged_in?
  end

  def destroy
  	@location = Location.find_by(params[:id]).delete
  	flash[:success] = Location deleted.
  	redirect_to directory_path
  end

  private

  	def location_params
  		params.require(:location).permit(:continent, :state, :city, :coordinate)
  	end

  	def admin_user
  		if !current_user.nil?
        redirect_to(root_url) unless current_user.admin?
      else
        redirect_to(root_url)
      end
    end
end
