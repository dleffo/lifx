require 'lifx'

tag = ARGV[0]
colour = ARGV[1]


#Sets lights in a room to a preset colour by name.  Knock yourself out with making colours

COLOURS = {
  'red' => [0, 1, 1, 3500],
  'yellow' => [50, 1, 1, 3500],
  'green' => [120, 1, 1, 3500],
  'blue' => [220, 1, 1, 3500],
  'lavender' => [280, 0.3, 0.1, 9000]
}

$:.unshift File.dirname(__FILE__)	#includes current directory in the path so that the discovery code can run
require 'discovery' #script for discovering bulbs and adds other requires

client = discovery()	#Discovers bulbs and returns lightcollection object
	
	lights = client.lights.with_tag(tag)							# Array of lights in the room
	print lights
	lights.set_color(LIFX::Color.hsbk(*COLOURS[colour]), duration: 0)	# turn the lights in a room on to set hue, saturation, brightness and kelvin over 'duration' seconds
	print("Colour has changed\n")				
	lights.turn_on
						
	print("------------------------------------------------------\n")
	client.flush
