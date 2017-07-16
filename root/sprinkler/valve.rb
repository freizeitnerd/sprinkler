#!/usr/bin/ruby
require "open3"

class Valve
  @@count_total = 0
  @@count_closed = 0
  @@count_open = 0
  @@gpios = []
  @@instances = []

  def count_total
    @@count_total
  end

  def initialize(name, gpio_number)
    puts "Init valve '#{name}' at GPIO#{gpio_number}"
    @gpio_number = gpio_number
    @name = name
    stdin, stdout, stderr = Open3.popen3("fast-gpio set-output #{gpio_number}")
    puts "stdout: #{stdout.gets}"
    puts "stderr: #{stderr.gets}"
    self.close

    @@count_total += 1
  end

  def set(value)
    stdin, stdout, stderr = Open3.popen3("fast-gpio set #{@gpio_number} #{value}")
    puts "stdout: #{stdout.gets}"
    puts "stderr: #{stderr.gets}"
  end

  def get
    stdin, stdout, stderr = Open3.popen3("fast-gpio read #{@gpio_number}")
    status = stdout.gets.to_s
    puts "stderr: #{stderr.gets}"
    status.split.last
  end

  def open
    set(0)
  end

  def close
    set(1)
  end

  def value(value)
    if value.nil?
      get()
    else
      set(value)
    end
  end

end

lawn1 = Valve.new("lawn1", 0)
lawn1.open
puts "Lawn1 is set to #{lawn1.get}"
sleep(1)
lawn2 = Valve.new("lawn2", 2)
lawn2.open
sleep(1)
lawn1.close
sleep(1)
lawn2.close
sleep(1)
rear = Valve.new("rear", 3)
puts "Rear is set to #{rear.get}"
puts "#{rear.count_total} valves attached"