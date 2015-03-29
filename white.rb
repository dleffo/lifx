# Set light to a brightness and temperature
$:.unshift File.dirname(__FILE__)	#includes current directory in the path so that the discovery code can run
require 'discovery' #script for discovering bulbs and adds other requires

name = ARGV[0]
brightness = ARGV[1].to_f
kelvin = ARGV[2]

client = discovery()	#Discovers bulbs and returns lightcollection object

lights = client.lights.with_tag(name)
print("brightness = #{brightness} kelvin = #{kelvin}\n")

client.sync do
	lights.turn_on
end
lights.set_color(LIFX::Color.hsbk(0, 0, brightness, kelvin), duration: 5)
print("Colour has changed\n")

print("------------------------------------------------------\n")

client.flush
