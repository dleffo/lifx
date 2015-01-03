#!/bin/bash
TZ='Australia/Sydney'  #May not be required.  Change timezone to your own.
source ~/.rvm/scripts/rvm
cd ~/lifx
#bundle exec ruby
~/lifx/sunwait sun down -1:00 34.0S 151.0E  #change latitude and longitude to suit your location.
ruby ~/lifx/sunset.rb

