class FriendshipsController < ApplicationController
  def search
    email = params[:email].strip
    @user = User.find_by(email: email)
    respond_to do |format|
      if @user
        @friendship = current_user.friendships.build(friend_id: @user.id )
        flash.now[:alert] = "Can't befriend yourself" if @friendship.befriending_oneself
        @friend = nil if !flash.now[:alert].nil?
      else
        flash.now[:alert] = email == "" ? "Email can't be blank" : "User does not exist"
      end
      format.js { render partial: "friends/friend.js" }
    end
  end

  def create
    @user = User.find_by(id: params[:id])
    respond_to do |format|
      if @user
        begin
          current_user.friends << @user
          flash.now[:success] = "You are now following #{@user.full_name}"
        rescue => exception
          flash.now[:alert] = exception.message.sub("Validation failed: ", "")
          @user = nil
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
