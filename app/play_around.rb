#!/usr/bin/ruby

require_relative "lib/settings"
CONFIG = get_config
SETTINGS = get_settings
ENV["gpio_mode"] = CONFIG["gpio_mode"]
require_relative "lib/valve_class"

lawn1 = Valve.new("lawn1", 0)
lawn2 = Valve.new("lawn2", 2)
rear = Valve.new("rear", 3)

lawn1.open
puts "Lawn1 is set to #{lawn1.get}"
sleep(0.3)
lawn2.open
sleep(0.3)
lawn1.close
sleep(0.3)
lawn2.close
sleep(0.3)
puts "Rear is set to #{rear.get}"
puts "#{rear.valves.size} valves attached"
lawn1.open
lawn2.open

puts "#{rear.valves_opened.size} valves opened"
puts "#{rear.valves_closed.size} valves closed"
rear.close_all
puts "#{rear.valves_opened.size} valves opened"
puts "#{rear.valves_closed.size} valves closed"
