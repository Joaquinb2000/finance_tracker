class CreateUserStocksTable < ActiveRecord::Migration[6.0]
  def change
    create_table :user_stocks_tables do |t|
      t.integer :user_id
      t.integer :stock_id
    end
  end
end
