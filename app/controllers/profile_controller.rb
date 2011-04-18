class ProfileController < ApplicationController
  def index
    @users = User.order('created_at desc').limit(5)
  end

  def show
    @message = Message.new if user_signed_in?
    if params[:username].nil? && user_signed_in?
      @user = current_user
      subscriptions = Subscription.find_all_by_user_id([@user.id], :select => :profile).map(&:profile)
      @messages = Message.find_all_by_user_id(subscriptions.push(@user.id))
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
    begin
      subscribed_profile = User.find_by_username!(params[:username])
    rescue
      redirect_to profiles_path
    end
    
    subcription = Subscription.new(:user_id => current_user.id, :profile => subscribed_profile.id)
    if subcription.save
      redirect_to profile_path, :notice => "You have successfully subscribed"
    else
      redirect_to profile_path, :notice => "Error occurred"
    end
  end
  def unsubscribe
    begin
      subscribed_profile = User.find_by_username!(params[:username])
      subscription = Subscription.where(:user_id => current_user.id, :profile => subscribed_profile.id).first
    rescue
      redirect_to profiles_path
    end
    redirect_to profile_path, :notice => 'Subscription was successfully deleted' if subscription.destroy
  end
end
