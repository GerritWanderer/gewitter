class MessagesController < ApplicationController
  def create
    params[:message][:user_id] = current_user.id
    @message = Message.new(params[:message])
    if @message.save
      redirect_to profile_path, :notice => 'Message was successfully created.'
    else
      @user = current_user
      @messages = @user.messages
      render 'profile/show'
    end
  end

  def destroy
    message = Message.find(params[:id])
    redirect_to profile_path, :notice => 'Message was successfully deleted' if message.destroy
  end
end
