# Required Ruby Libraries for Parsing #

require 'csv'
require 'json'
require 'net/http'


# Intialize an Array of the JSON Queries #

query = ['http://api.meetup.com/groups.json/?&topic=deals-and-bargins&order=members&key=781515511760134362715d533e4e65', 'http://api.meetup.com/groups.json/?&topic=deals-and-bargins&order=members&key=7815155s11760134362715d533e4e65'] 

# Intialize CSV File and Insert Headers #

CSV.open("meeetup.csv", "ab") do |csv|
	csv << ["visibility", "link", "organizer_id", "state", "join_mode", "city", "who", "id", "description", "name", "members", "zip", "organizer_name", "organizerProfileURL", "rating"]
end

# Make API Request in JSON #

query.each do |q|

	uri = URI(q)
	request = Net::HTTP.get(uri)

	# Parse JSON #

	f = JSON.parse(request)

	# Insert Data into CSV #

	CSV.open("meeetup.csv", "ab") do |csv|
		f["results"].each do |hash|
			csv << [hash["visibility"], hash["link"], hash["organizer_id"], hash["state"], hash["join_mode"], hash["city"], hash["who"], hash["id"], hash["description"].unpack("C*").pack("U*"), hash["name"], hash["members"], hash["zip"], hash["organizer_name"], hash["organizerProfileURL"], hash["rating"]]
		end
	end

end