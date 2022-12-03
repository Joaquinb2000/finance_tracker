class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :befriendable

  def befriendable
    errors.add(:users, "can't befriend themselves") if befriending_oneself
    errors.add(:users, "are friends already") if is_friend
  end

  def befriending_oneself
    user_id == friend_id
  end

  def is_friend
    !Friendship.find_by(user_id: user_id, friend_id: friend_id).nil?
  end
end
