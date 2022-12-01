# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
  user = User.create(email: Faker::Internet.email, password: "password")
  (rand(3..5)).times do
    ticker = Faker::Finance.ticker
    stock = Stock.find_by(ticker: ticker) || Stock.new_lookup(ticker)
    user.stocks << stock
  end
end
