class ProfileController < ApplicationController  
  def index
    @message = Message.new if user_signed_in?
    @messages = Message.all
  end

  def show
    @message = Message.new if user_signed_in?
    
    # if no user selected and you are logged in, show private profile page
    if params[:username].nil? && user_signed_in?
      @user = current_user
      subscriptions = Subscription.find_all_by_user_id([@user.id], :select => :profile).map(&:profile)
      @messages = Message.find_all_by_user_id(subscriptions.push(@user.id)) + Mention.find_all_by_user_id(@user.id).map(&:message)
      @messages = @messages.sort_by { |m| m["created_at"] }.reverse
    else # Try to find selected User, else redirect to root
      begin
        @user = User.find_by_username!(params[:username])
        @messages = @user.messages
      rescue
        redirect_to profiles_path, :notice => 'Sorry, User does not exist'
      end
    end
  end

  def subscribe
    # find user and create subscription record
    begin
      subscribed_profile = User.find_by_username!(params[:username])
    rescue
      redirect_to profiles_path
    end
    subscription = Subscription.new(:user_id => current_user.id, :profile => subscribed_profile.id)
    authorize! :create, subscription
    
    if subscription.save
      flash[:notice] = "You have successfully subscribed"
    else
      flash[:alert] = "Error occurred while subscribing the User"
    end
    redirect_to profile_path
  end
  
  def unsubscribe
    # find user and delete subscription record
    begin
      subscribed_profile = User.find_by_username!(params[:username])
      subscription = Subscription.where(:user_id => current_user.id, :profile => subscribed_profile.id).first
    rescue
      redirect_to profiles_path, :alert => 'Subscription was not found'
    end
    authorize! :destroy, subscription
    redirect_to profile_path, :notice => 'Subscription was successfully deleted' if subscription.destroy
  end
end
