class StocksController < ApplicationController
  def search
    if params[:ticker].empty?
      flash.now[:alert] = "Input cannot be blank"
      redirect_to my_portfolio_path
    else
      @stock = Stock.new_lookup(params[:ticker])
      flash[:alert] = @stock if @stock.class == String
      render "users/my_portfolio"
    end
  end

end
