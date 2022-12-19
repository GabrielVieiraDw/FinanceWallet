class Stock < ApplicationRecord

  def self.new_lookup(ticker)
    client = IEX::Api::Client.new(publishable_token: Rails.application.credentials.iex_client[:iex_api_key],
                                  endpoint: 'https://sandbox.iexapis.com/v1')
    client.price(ticker)                                  
  end
end
