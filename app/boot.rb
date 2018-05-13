#!/usr/bin/ruby

require_relative "lib/init_logger"
require_relative "lib/settings"

CONFIG = get_config

logger = init_logger

sprinklers = {}

CONFIG["sprinklers"].each do |sprinkler|
  sprinkler[sprinkler["name"].to_s] = Omega2Gpio::Output.new(sprinkler["gpio"])
  msg = "Close sprinkler #{sprinkler['name']} at GPIO #{sprinkler['gpio']}"
  logger.info msg
  puts msg
end

