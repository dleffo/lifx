# Sunrise script for a bulb named "Bedroom".  Used with cron job and sunrise.sh to slowly turn on light from dull orange to bright(er) yellow.
$:.unshift File.dirname(__FILE__)	#includes current directory in the path so that the discovery code can run
require 'discovery' #script for discovering bulbs and adds other requires

client = discovery()	#Discovers bulbs and returns lightcollection object
lights = client.lights.with_tag("Bedroom")
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
			lights.set_color(LIFX::Color.hsl(40,1,0.01), duration: 0)		# set the colour to 1% white before turning on
			sleep 1																# wait 1 second.  This gives the light time to set the colour above.
			lights.turn_on														# turn the lights in the room on.
			lights.set_color(LIFX::Color.hsb(0.967, 0.0, 0.27), duration: 900)	# slowly turn the light on to set hue, saturation, brightness and kelvin over 'duration' seconds
			print("Colour has changed\n")										
			print("------------------------------------------------------\n")
		end
client.flush