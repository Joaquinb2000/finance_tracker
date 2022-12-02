class Stock < ApplicationRecord
  has_many :user_stocks, dependent: :destroy
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true, uniqueness: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex[:public_key],
      secret_token: Rails.application.credentials.iex[:secret_key],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    begin
      stock = client.quote(ticker_symbol.upcase)
      new(
        ticker: stock.symbol,
        name: stock.company_name,
        last_price: stock.latest_price
      )
    rescue => exception
      nil
    end
  end
end
