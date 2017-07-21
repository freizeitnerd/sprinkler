#!/usr/bin/ruby

require_relative 'lib/settings'
CONFIG = get_config
SETTINGS = get_settings
ENV["gpio_mode"] = CONFIG["gpio_mode"]
require_relative "lib/valve"

puts 'Initialize Sprinkler-Bot'

# Close all Valves, by init them
tap = init_tap(CONFIG['tap_gpio'], SETTINGS['tap_name'])
sprinklers = init_all_sprinklers(CONFIG['gpio_numbers'], SETTINGS['valve_names'])

