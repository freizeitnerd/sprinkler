require_relative "settings"
require_relative "valve_class"

class Sprinkler < Valve
  @@settings = get_settings

  def next_scheduled_watering
    @@settings[self.gpio_number].
    {
        start_at: start_at,
        end_at: end_at,
    }
  end


  def next_optimized_watering
    # just a dummy :-)
    next_scheduled_watering
  end


  def has_sprinkel_time_now?
    if next_optimized_watering.start_at >= @@settings[self.gpio_number].start_at && next_optimized_watering.end_at <= @@settings[self.gpio_number].end_at
      true
    else
      false
    end
  end


  def time_contraint_present
    false
  end
end