class UsersController < ApplicationController
  def my_wallet
    @tracked_stocks = current_user.stocks
  end

  def friends
    @friends = current_user.friends
  end
end
