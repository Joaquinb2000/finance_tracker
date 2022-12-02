class FriendshipsController < ApplicationController
  def search
    email = params[:email].strip
    @friend = User.find_by(email: email)
    respond_to do |format|
      if @friend
        friendship = Friendship.new( user_id: current_user.id, friend_id: @friend.id )
        flash.now[:alert] = friendship.errors.full_messages.join("\n") if !friendship.valid?
        @friend = nil if !flash.now[:alert].nil?
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

  def destroy
    friendship = Friendship.find_by(user_id: current_user.id, friend_id: params[:id])
    friend = User.find(params[:id])
    if friendship
      friendship.destroy
      flash[:success] = "Stopped following #{friend.email}"
    else
      flash[:alert] = "Users are not friends"
    end
    redirect_to my_friends_path
  end

end
