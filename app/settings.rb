require 'json'
def get_config
  JSON.parse(File.read('../config/config.json'))
end
def get_settings
  JSON.parse(File.read('../config/settings.json'))
end
