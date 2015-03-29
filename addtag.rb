# Adds a tag to a bulb
# Command line example:
# "ruby addtag.rb Lounge1 Lounge"
#
$:.unshift File.dirname(__FILE__)	#includes current directory in the path so that the discovery code can run
require 'lifx'
require 'discovery' #script for discovering bulbs and adds other requires


name = ARGV[0]
tag = ARGV[1]

if ARGV.empty?
	print("Adds a tag to a lightbulb. \n")
	print("Usage Example commandline:\nruby addtag.rb Lounge1 Lounge\n to add the tag 'Lounge' the lightbulb 'Lounge1'.\n")
	exit
end
client = discovery()	#Discovers bulbs and returns lightcollection object
light = client.lights.with_label(name)
light.add_tag(tag)
client.flush