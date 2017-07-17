require './settings'
CONFIG = get_config
SETTINGS = get_settings
ENV["gpio_mode"] = CONFIG["gpio_mode"]
require "./valve"
require "./sprinkler"
require "./tap"
require "./init_all_sprinklers"
require "./init_tap"

tap = init_tap(CONFIG['tap_gpio'], SETTINGS['tap_name'])
sprinklers = init_all_sprinklers(CONFIG['gpio_numbers'], SETTINGS['valve_names'])

# Open the sprinkler
#   if its time to open it, if frequence is reached (last watering is more than freuqence days ago)
#   if no time constraint is present
#   if no other sprinkler is open
puts sprinklers[0].next_scheduled_run
puts sprinklers[0].open


puts "Nothing more yet"
