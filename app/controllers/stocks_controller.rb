class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.new_stock_search(params[:stock])
      if @stock
        render 'users/my_wallet'
      else
        flash[:alert] = "Please enter a valid symbol"
        redirect_to my_wallet_path
      end
    else
      flash[:alert] = "Please enter a symbol"
      redirect_to my_wallet_path
    end
  end

end