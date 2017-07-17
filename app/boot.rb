require './settings'
CONFIG = get_config
SETTINGS = get_settings
ENV["gpio_mode"] = CONFIG["gpio_mode"]
require "./valve"

puts 'Initialize Sprinkler-Bot'

# Close all Valves
valves = []
for i in 0..CONFIG['gpio_numbers'].size-1
  puts "Initiate Valve '#{SETTINGS['valve_names'][i]}' at GPIO#{CONFIG['gpio_numbers'][i]}"
  valve = Valve.new(SETTINGS['valve_names'][i], CONFIG['gpio_numbers'][i])
  valve.close
  valves.push(valve)
end
