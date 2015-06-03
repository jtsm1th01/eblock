#Charity.create(name: "NorCal Autism Research Foundation",
#                email: "auction@charity.com")

 t = Time.now
 Auction.create(      name: "Spring Fundraiser",
                charity_id: 1,
                     start: t,
                    finish: (t + 86400))

 User.create!(fname: "Julian",
              lname: "Bishop",
              email: "jbishop@xtol.com",
              password: "anex1234",
              password_confirmation: "anex1234")

70.times do |n|
  name = Faker::Commerce.product_name
  description = "You know you want it!"
  Item.create!(name: name,
               description: description,
               auction_id: 1,
               user_id: 1,
               value: n + 1 * 10,
               starting_bid: 20,
               bid_increment: 10)
end
  



# (1..10).each do |number|
#   Item.create(auction_id: 1,
#                  user_id: 1,
#                     name: "piano " + number.to_s,
#              description: "old and out of tune",
#                    value: number * 10000)
#   Bid.create(    item_id: number,
#                  user_id: 1,
#                   amount: number * 20)
# end
  



