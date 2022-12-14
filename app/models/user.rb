class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stocks_tracked?(ticker)
    stock = Stock.check_stock(ticker)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  def under_stock_limit?
    stocks.count < 10
  end         

  def stock_tracker_enabled?(ticker)
    under_stock_limit? && !stocks_tracked?(ticker)
  end

  def full_name
    "#{first_name} #{last_name}" if first_name || last_name
    "Anonymus"
  end
end