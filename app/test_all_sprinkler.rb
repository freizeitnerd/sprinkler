#!/usr/bin/ruby
require "omega2_gpio"

require_relative "lib/settings"
require_relative "lib/init_logger"
CONFIG = get_config

logger = init_logger(STDOUT)

sprinklers = []

CONFIG['gpio_numbers'].each do |gpio_number|
  sprinkler = Omega2Gpio::Output.new(gpio_number).high
  sprinklers.push( sprinkler )
  logger.info "Open valve at GPIO #{gpio_number}"
  sprinkler.low # open valve
  sleep(10) # keep valve open for duration_in_minutes
  logger.info "Close valve at GPIO #{gpio_number}"
  sprinkler.high # close valve
  sleep(1)
end