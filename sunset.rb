# Sunset script for rooms.  Used with cron job and sunset.sh to slowly turn on light from 1% to the brightness and colour you like.
# Needs sunwait program to determine when the sun will set for your lat/long and date of the year.

$:.unshift File.dirname(__FILE__)	#includes current directory in the path so that the discovery code can run
require 'discovery' #script for discovering bulbs and adds other requires

client = discovery()	#Discovers bulbs and returns lightcollection object
duration = 3600			#How long in seconds to go from 1% to b brightness
	
	def sunset (client, tag, h, s, b, kelvin, duration)						# passes in client object, tag (or room), hue, saturation, brightness, kelvin 

	lights = client.lights.with_tag(tag)							# Array of lights in the room
	on = false														# If any light is on in the room, does not proceed.  This stops the lights dimming to 1% in the room if you already have them turned on
		lights.each do |l|											# Iterates through each light in the array.  
			if l.on?()												# If a light is on, print out that it is on and then break out of the loop as there is no need to verify other lights.  Your taste may differ to mine... you have the code.
				puts "\nLight #{l.label} is on."					
				on = true											# Set on to be true.  Later this is used to not modify the light settings for a room that already has at least one light on.
				break
			else
				puts "\nLight #{l.label} is off."					# If light is off, print it's off
			end
		end
		if on == false															# If no lights are on in the room
			lights.set_color(LIFX::Color.hsl(0, 0, 0.01), duration: 0.1)		# set the colour to 1% white before turning on
			sleep 1																# wait 1 second.  This gives the light time to set the colour above.
			lights.turn_on														# turn the lights in the room on.
			off = false	#check lights actually turned on.
			lights.each do |l|
				while l.off?(refresh: true)
					puts "\nLight #{l.label} is still off.  Retrying..."
					l.turn_on
					sleep(0.5)
				end
			end
			lights.set_color(LIFX::Color.hsbk(h, s, b, kelvin), duration: duration)	# slowly turn the light on to set hue, saturation, brightness and kelvin over 'duration' seconds
			print("Colour has changed\n")										
			print("------------------------------------------------------\n")
		end
	client.flush
				
end

# Run sunset code for your rooms.  Examples below
sunset(client, "Lounge", 0, 0, 1, 3400, duration)
sunset(client, "Study", 0, 0, 1, 5400, duration)
sunset(client, "Bedroom", 0, 0, 0.3, 2500, duration)

