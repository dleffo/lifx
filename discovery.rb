#discovers lightbulbs.  Used by all other scripts.

def discovery
	require 'lifx'		# lifx API

	print("------------------------------------------------------\n")
	print("Discovering bulb\n")

################################################
# variables
bulbs = 8	#set to the number of bulbs you have once this number of bulbs is found, there's no point continuing to search
################################################



	puts "initialising client"
	client = LIFX::Client.lan										# initialise
	puts "discovering..."
	begin
		client.discover! { |c| c.lights.count >= bulbs }
		puts "discovery complete..."
	rescue
		puts "discover failed..."
	end
	puts "returning lightcollection"
	puts client.lights
	return (client)
	end
