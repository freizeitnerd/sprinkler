#!/usr/bin/ruby

require_relative "lib/settings"
CONFIG = get_config
SETTINGS = get_settings
ENV["gpio_mode"] = CONFIG["gpio_mode"]
require_relative "lib/valve_class"
require_relative "lib/sprinkler_class"
require_relative "lib/tap_class"
require_relative "lib/init_all_sprinklers"
require_relative "lib/init_tap"

tap = init_tap(CONFIG['tap_gpio'], SETTINGS['tap_name'])
sprinklers = init_all_sprinklers(CONFIG['gpio_numbers'], SETTINGS['valve_names'])


# Open the sprinkler
#   if its time to open it, if frequence is reached (last watering is more than freuqence days ago)
#   if no time constraint is present
#   if no other sprinkler is open, to prevent pressure drop
if sprinklers[0].has_sprinkel_time_now? and sprinklers[0].is_closed?
  puts "Watering #{sprinklers[0].name}..."
  sprinklers[0].open
end
