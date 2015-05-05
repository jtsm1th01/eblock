Charity.create(name: "NorCal Autism Research Foundation")

t = Time.now
Auction.create(      name: "Spring Fundraiser",
               charity_id: 1,
                    start: t,
                   finish: (t + 86400))

User.create(fname: "Julian",
            lname: "Bishop",
            email: "jbishop@xtol.com")

(1..10).each do |number|
  Item.create(auction_id: 1,
                 user_id: 1,
                    name: "piano " + number.to_s,
             description: "old and out of tune",
                   value: number * 10000)
  Bid.create(    item_id: number,
                 user_id: 1,
                  amount: number * 20)
end
  



