require "json"
require "omega2_gpio"

def get_config
  path = [__dir__, "../../config/config.json"].join("/")
  config = {}
  unless File.exist?(path) then
    puts "***HELP: Config file is missing in config path."
    puts "         You may copy the example file from"
    puts "           sprinkler/config/example/config.json to "
    puts "           sprinkler/config/config.json"
    puts "         Please review the configuration. Set the 'mock' to true to make sure you don't damage your hardware."
  end

  config = JSON.parse(File.read(path))

  Omega2Gpio.configuration.mock = config["mock"]
  Omega2Gpio.configuration.messaging_level = config["messaging_level"]

  config
end


def get_settings
  path = [__dir__, "../../config/settings.json"].join("/")
  JSON.parse(File.read(path))
end
