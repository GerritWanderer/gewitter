class ProfileController < ApplicationController
  def index
    @users = User.order('created_at desc').limit(5)
  end

  def show
    @message = Message.new if user_signed_in?
    if params[:username].nil? && user_signed_in?
      @user = current_user
      @messages = @user.messages
    else
      begin
        @user = User.find_by_username!(params[:username])
        @messages = @user.messages
      rescue
        redirect_to profiles_path
      end
    end
  end

  def subscribe
  end
end
