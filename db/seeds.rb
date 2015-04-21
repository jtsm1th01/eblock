Charity.create(name: "NorCal Autism Research Foundation")

t = Time.now
Auction.create(name: "Spring Fundraiser", charity_id: 1, start: t, finish: (t + 86400))

User.create(fname: "Julian", lname: "Bishop", email: "jbishop@xtol.com")

Item.create(auction_id: 1, user_id: 1, name: "piano", description: "old and out of tune", value: 2000)



