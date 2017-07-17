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

sprinklers.each do |sprinkler|
  puts "Open Sprinkler '#{sprinkler.name}'"
  sprinkler.open
  sleep(1)
end