class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.new_stock_search(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid symbol"
          format.js { render partial: 'users/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a symbol"
        format.js { render partial: 'users/result' }
      end
    end
  end

  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: 1, stock_id: stock).first
    user_stock.destroy
    flash[:notice] = "#{sotck.ticker} successfully removed"
    redirect_to my_wallet_path
  end  

end