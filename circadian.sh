#!/bin/bash
TZ='Australia/Sydney'  #May not be required.  Change timezone to your own.
source ~/.rvm/scripts/rvm
cd ~/lifx
#bundle exec ruby
~/lifx/sunwait sun down 0:00 34.0S 151.0E  #change latitude and longitude to suit your location.
ruby ~/lifx/setcolour.rb Bedroom 39.6 0.93 1 3500 3600
~/lifx/sunwait sun down 1:00 34.0S 151.0E
ruby ~/lifx/setcolour.rb Bedroom 30 1 0.3 3500 10800


