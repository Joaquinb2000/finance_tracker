class StocksController < ApplicationController
  def search
    respond_to do |format|
      if params[:ticker].empty?
        flash.now[:alert] = "Input cannot be blank"
      else
        @stock = user_tracked_stock(params[:ticker])
      end
      format.js { render partial: 'stock.js' }
    end
  end

  private
  def user_tracked_stock(ticker)
    stock = nil
    if current_user.stocks.find_by(ticker: ticker)
      flash.now[:alert] = "That stock is part of your portfolio already"
    else
      stock = Stock.new_lookup(ticker)
      flash.now[:alert] = "Ticker symbol does not exist in database" if stock.nil?
    end
    stock
  end
end
