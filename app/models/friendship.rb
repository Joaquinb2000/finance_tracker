class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :cant_befriend_oneself, :is_friend_already

  def cant_befriend_oneself
    if user_id == friend_id
      errors.add(:users, "can't befriend themselves")
    end
  end

  def is_friend_already
    if Friendship.find_by(user_id: user_id, friend_id: friend_id)
      errors.add(:users, "are friends already")
    end
  end
end
