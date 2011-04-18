class MessagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :only => [:create, :destroy]
  
  def create
    if @message.save
      redirect_to profile_path, :notice => 'Message was successfully created.'
    else
      @user = current_user
      subscriptions = Subscription.find_all_by_user_id([@user.id], :select => :profile).map(&:profile)
      @messages = Message.find_all_by_user_id(subscriptions.push(@user.id))
      render 'profile/show'
    end
  end

  def destroy
    redirect_to profile_path, :notice => 'Message was successfully deleted' if @message.destroy
  end
end
