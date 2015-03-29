require 'lifx'

tag = ARGV[0]
hue = ARGV[1].to_f
saturation = ARGV[2].to_f
brightness = ARGV[3].to_f
kelvin = ARGV[4].to_f
duration = ARGV[5].to_f

#Sets lights in a room to a given colour on the native hsbk scale.  Does not change the on/off state

$:.unshift File.dirname(__FILE__)	#includes current directory in the path so that the discovery code can run
require 'discovery' #script for discovering bulbs and adds other requires

client = discovery()	#Discovers bulbs and returns lightcollection object
	
	lights = client.lights.with_tag(tag)							# Array of lights in the room
	lights.set_color(LIFX::Color.hsbk(hue, saturation, brightness, kelvin), duration: duration)	# slowly turn the light on to set hue, saturation, brightness and kelvin over 'duration' seconds
	print("Colour has changed\n")										
	print("------------------------------------------------------\n")
	client.flush
