#discovers lightbulbs.  Used by all other scripts.

def discovery
	require 'lifx'		# lifx API

	print("------------------------------------------------------\n")
	print("Discovering bulb\n")

################################################
# variables
bulbs = 8	#set to the number of bulbs you have once this number of bulbs is found, there's no point continuing to search
################################################



	client = LIFX::Client.lan										# initialise
	client.discover													# client discovery.  You wont find anything without this command
	t = lastCount =0												# t for number of times through the while loop, lastCount is the number of returned bulbs
		while t < 4 && lastCount < bulbs do								# while loop for finding lights
			client.lights.refresh									# Requests lights to report their state.  Cannot guarantee message was received... hence the loop.
			client.flush											# wait until packets sent
			if client.lights.count > lastCount						# updates lastCount to number of bulbs discovered if more discovered
				lastCount = client.lights.count
				puts "\nLights found: #{client.lights.count}"		# prints out the last count of number of bulbs
			else													# if no bulbs discovered, increment t
				t += 1
				puts "\nt: #{t}"									# prints out current value of t
			end
			sleep 0.5												# sleep for half a second before looping again
		end
		puts client	
		return (client)

		end
