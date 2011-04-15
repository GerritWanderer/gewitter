class ProfileController < ApplicationController
  def index
    @users = User.order('created_at desc').limit(5)
  end

  def show
    @user = User.find_by_username!(params[:username])
    rescue
      render :error 
  end

end
