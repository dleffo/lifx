# Turns off the bulb.
# Command line example:
# "ruby off.rb Study"
#
$:.unshift File.dirname(__FILE__)	#includes current directory in the path so that the discovery code can run
require 'lifx'
require 'discovery' #script for discovering bulbs and adds other requires


name = ARGV[0]

if ARGV.empty?
	print("Turns off a lightbulb. \n")
	print("Usage Example commandline:\nruby off.rb Study\n to turn the lightbulb 'Study' off.\n")
	exit
end
client = discovery()	#Discovers bulbs and returns lightcollection object
light = client.lights.with_tag(name)
light.turn_off

client.flush