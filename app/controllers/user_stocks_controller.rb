class UserStocksController < ApplicationController

  def create
    stock = Stock.check_stock(params[:ticker])
    if stock.blank?
      stock = Stock.new_stock_search(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} added"
    redirect_to my_wallet_path
  end
end