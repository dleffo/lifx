# Set light to a brightness and temperature
$:.unshift File.dirname(__FILE__)	#includes current directory in the path so that the discovery code can run
require 'discovery' #script for discovering bulbs and adds other requires

name = ARGV[0]
brightness = ARGV[1].to_f
kelvin = ARGV[2]

client = discovery()	#Discovers bulbs and returns lightcollection object

if client.lights.with_label(name)
	light = client.lights.with_label(name)
end
if client.lights.with_tag(name)
	light = client.lights.with_tag(name)
end	

print("brightness = #{brightness} kelvin = #{kelvin}\n")

light.turn_on
light.set_color(LIFX::Color.hsbk(0, 0, brightness, kelvin), duration: 5)
sleep 1
print("Colour has changed\n")

print("------------------------------------------------------\n")

client.flush
