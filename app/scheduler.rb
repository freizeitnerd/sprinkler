#!/usr/bin/ruby

require "cron_parser"
require "time"
require "date"
require_relative "lib/init_logger"
require_relative "lib/settings"

CONFIG = get_config

logger = init_logger

sprinklers = {}

CONFIG["sprinklers"].each do |sprinkler|
  sprinkler[sprinkler["name"].to_s] = Omega2Gpio::Output.new(sprinkler["gpio"])
  puts "Instatiate sprinkler #{sprinkler['name']}"
  puts "  value is " + sprinkler[sprinkler["name"].to_s].value.to_s
end


CONFIG["sprinklers"].each do |sprinkler|
  puts sprinkler["name"]
  unless sprinkler["schedules"].nil?
    sprinkler["schedules"].each do |schedule|
      puts "it is #{Time.now}"
      # logger.info "scheduler triggered"
      cron_parser = CronParser.new( schedule['trigger_in_cron_style'] )
      last_start = cron_parser.last(Time.now)
      next_start = cron_parser.next(Time.now)
      last_end = last_start + schedule['duration_in_minutes']*60
      next_end = next_start + schedule['duration_in_minutes']*60
      is_active = Time.now.between?(last_start, last_end)
      puts "  is active till #{last_end}" if is_active
      puts "   last start: #{last_start.to_s}"
      puts "   next start: #{next_start.to_s}"


      if is_active and sprinkler[sprinkler["name"].to_s].high? then
        # valve is closed but should be open --> start sprinkler
        msg = "Open sprinkler #{sprinkler['name']} for #{schedule['duration_in_minutes']}"
        logger.info msg
        puts msg
        sprinkler[sprinkler["name"].to_s].low
      elsif !is_active and sprinkler[sprinkler["name"].to_s].low? then
        # valve is open but should be closed --> stop sprinkler
        msg = "Close sprinkler #{sprinkler['name']}"
        logger.info msg
        puts msg
        sprinkler[sprinkler["name"].to_s].high
      else
        puts "Error: Close #{sprinkler['name']}"
        Omega2Gpio::Output.new(sprinkler["gpio"]).high
      end
    end
  end
end