#!/usr/bin/ruby

require "omega2_gpio"
require_relative "lib/init_logger"
require_relative "lib/settings"
CONFIG = get_config

logger = init_logger


gpio_number = 0 # lawn
duration_in_minutes = 1 # minutes
name = "lawn"


valve = Omega2Gpio::Output.new(gpio_number).high

logger.info "Open #{name} valve for #{duration_in_minutes} minutes"
valve.low # open valve
sleep(duration_in_minutes*60) # keep valve open for duration_in_minutes

logger.info "Close #{name} valve"
valve.high # close valve
