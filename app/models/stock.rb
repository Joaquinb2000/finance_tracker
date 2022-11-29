class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex[:public_key],
      secret_token: Rails.application.credentials.iex[:secret_key],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    begin
      client.quote(ticker_symbol).latest_price
    rescue => exception
      "Ticker symbol does not exist in database"
    end
  end
end
