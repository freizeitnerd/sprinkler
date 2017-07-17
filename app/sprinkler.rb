require './settings'
require "./valve"

class Sprinkler < Valve
  @@SETTINGS = get_settings

  def next_scheduled_run
    Time.now
  end


  def next_optimized_run
    next_scheduled_run
  end


  def time_contraint_present
    true
  end
end