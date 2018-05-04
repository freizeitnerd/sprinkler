require "json"

def get_config
  path = [__dir__, "../../config/config.json"].join("/")
  JSON.parse(File.read(path))
end
def get_settings
  path = [__dir__, "../../config/settings.json"].join("/")
  JSON.parse(File.read(path))
end
