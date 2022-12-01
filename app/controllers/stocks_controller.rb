class StocksController < ApplicationController
  def search
    respond_to do |format|
      if params[:ticker].empty?
        flash.now[:alert] = "Input cannot be blank"
      else
        @stock = Stock.new_lookup(params[:ticker])
        flash.now[:alert] = "Ticker symbol does not exist in database" if @stock.nil?
      end
      format.js { render partial: 'stock.js' }
    end
  end
end
