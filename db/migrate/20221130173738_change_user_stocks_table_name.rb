class ChangeUserStocksTableName < ActiveRecord::Migration[6.0]
  def change
    rename_table :user_stocks_tables, :user_stocks
  end
end
