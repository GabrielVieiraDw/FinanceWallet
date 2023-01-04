class UsersController < ApplicationController
  def my_wallet
    @tracked_stocks = current_user.stocks
  end
end
