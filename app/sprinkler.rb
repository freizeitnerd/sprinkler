require "./valve"

class Sprinkler < Valve
  def next_run
    Time.now
  end
end