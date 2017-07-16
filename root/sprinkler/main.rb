#!/usr/bin/ruby

puts system('ls /sys/class/leds')
puts exec('echo none > /sys/class/leds/omega2p:amber:system/trigger')

'fast-gpio set 0 0'
puts exec('fast-gpio set 2 1')

sleep(1)
puts exec('echo heartbeat > /sys/class/leds/omega2p:amber:system/trigger')

puts exec('cat /sys/class/leds/omega2p:amber:system/trigger')
puts 'end'