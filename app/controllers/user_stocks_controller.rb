class UserStocksController < ApplicationController
  def create
    ticker = params[:ticker]
    @stock = Stock.find_by(ticker: ticker) || Stock.new_lookup(ticker)
    respond_to do |format|
    if @stock
      begin
        current_user.stocks << @stock
        flash.now[:sucess] = "Successfully added #{@stock.name} to your portfolio"
      rescue => exception
        flash.now[:alert] = exception.message.sub("Validation failed: ", "")
        @stock = nil
      end
    else
      flash.now[:alert] = "Invalid ticker symbol"
    end
     format.js {render partial: "tracked_stocks.js"}
    end
  end

  def destroy
    record = UserStock.find_by(user_id: current_user.id, stock_id: params[:id])
    if record.destroy
      flash[:sucess] = "Stock successfully removed"
    else
      flash[:alert] = "User does not have that stock in their portfolio"
    end
    redirect_to my_portfolio_path
  end
end
