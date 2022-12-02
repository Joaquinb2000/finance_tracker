class UserStock < ApplicationRecord
  belongs_to :user
  belongs_to :stock
  validate :no_repeat, :tracked_stocks_limit

  def no_repeat
    if UserStock.find_by(user_id: user_id, stock_id: stock_id)
      errors.add(:stock, "already associated to current user" )
    end
  end

  def tracked_stocks_limit
    if UserStock.where(user_id: user_id).count >= 10
      errors.add(:users, "cannot track more than 10 stocks at a time")
    end
  end
end
