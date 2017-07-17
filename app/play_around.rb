#!/usr/bin/ruby
require "valve.rb"

lawn1 = Valve.new("lawn1", 0)
lawn1.open
puts "Lawn1 is set to #{lawn1.get}"
sleep(1)
lawn2 = Valve.new("lawn2", 2)
lawn2.open
sleep(1)
lawn1.close
sleep(1)
lawn2.close
sleep(1)
rear = Valve.new("rear", 3)
puts "Rear is set to #{rear.get}"
puts "#{rear.count_total} valves attached"