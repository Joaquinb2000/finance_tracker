class FriendshipsController < ApplicationController
  def search
    email = params[:email].strip
    @friend = User.find_by(email: email)
    respond_to do |format|
      if @friend
        valid_action
      else
        flash.now[:alert] = email == "" ? "Email can't be blank" : "User does not exist"
      end
        format.js {render partial: "friends/friend.js"}
    end
  end

  def create
    @friend = User.find_by(id: params[:id])
    respond_to do |format|
      if @friend
        begin
          current_user.friends << @friend
        rescue => exception
          flash.now[:alert] = exception.message.sub("Validation failed: ", "")
          @friend = nil
        end
      else
        flash.now[:alert] = "User does not exist"
      end
      format.js {render partial: "friendships/friendship.js"}
    end
  end

  private

  def valid_action
    friendship = Friendship.new( user_id: current_user.id, friend_id: @friend.id )
    flash.now[:alert] = friendship.errors.full_messages.join("\n") if !friendship.valid?
    @friend = nil if !flash.now[:alert].nil?
  end
end
