class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

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

  def self.search(params)
    params.strip!
    to_send_back = (first_name_searchs(params) + last_name_searchs(params) + email_searchs(params)).uniq
    return nil unless to_send_back
    to_send_back
  end

  def self.first_name_searchs(params)
    searchs('first_name', params)
  end

  def self.last_name_searchs(params)
    searchs('last_name', params)
  end

  def self.email_searchs(params)
    searchs('email', params)
  end

  def self.searchs(field_name, params)
    where("#{field_name} LIKE ?", "%#{params}%")
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def not_friends_with?(friend_id)
    !self.friends.where(id: friend_id).exists?
  end
end