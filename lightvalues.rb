# Returns values of the bulb.  Handy for checking scripts/fault finding.
# Command line example:
# "ruby lightvalues.rb Study"
#
$:.unshift File.dirname(__FILE__)	#includes current directory in the path so that the discovery code can run
require 'lifx'
require 'discovery' #script for discovering bulbs and adds other requires


name = ARGV[0]

if ARGV.empty?
	print("Returns the values of a lightbulb. \n")
	print("Usage Example commandline:\nruby lightvalues.rb Study\n to return the values for the lightbulb 'Study'.\n")
	exit
end
client = discovery()	#Discovers bulbs and returns lightcollection object

light = client.lights.with_label(name)
print("Bulb Name: ")
puts light.label()
print("Bulb Colour: ")
puts light.color()
print("Bulb Groups: ")
puts light.tags()
print("Bulb power: ")
puts light.power()
print("Bulb time: ")
puts light.time
print("Bulb temp: ")
puts light.temperature
print("Latency: ")
puts light.latency
if light.on?()
	print("Bulb is on\n")
else
	print("Bulb is off\n")
end
puts light.to_s
print("------------------------------------------------------\n")
client.flush