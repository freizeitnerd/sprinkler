class Settings < PersistentObject
  @@path = [__dir__, "../data/valves_log.yml"].join("/")
  @@settings = YAML::Store.new(@@path)


end
