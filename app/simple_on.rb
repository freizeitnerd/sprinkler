#!/usr/bin/ruby

require "omega2_gpio"

gpio_number = 0 # lawn
duration_in_minutes = 20 # minutes
name = "lawn"


valve = Omega2Gpio::Output.new(gpio_number).high

puts "Open #{name} valve"
valve.low # open valve
sleep(duration_in_minutes*60*1000) # keep valve open for duration_in_minutes

puts "Close #{name} valve"
valve.high # close valve
