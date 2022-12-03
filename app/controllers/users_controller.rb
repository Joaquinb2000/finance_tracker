class UsersController < ApplicationController
  def my_portfolio
    @stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
    @stocks = @user.stocks
    @is_friend = current_user.friends.find_by(email: @user.email )
    render "show"
  end
end
