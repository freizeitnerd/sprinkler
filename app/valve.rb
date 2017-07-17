#!/usr/bin/ruby
require "open3"

class Valve
  @@gpios = []
  @@valves = []
  @@valves_all = {}
  @@valves_opened = {}
  @@valves_closed = {}

  def initialize(name, gpio_number)
    puts "Init valve '#{name}' at GPIO#{gpio_number}"
    @gpio_number = gpio_number
    @name = name

    stdin, stdout, stderr = Open3.popen3("fast-gpio set-output #{gpio_number}")
    if stderr.gets
      raise(OnionGpioWrapperError, stderr.gets)
    end

    self.close

    @@gpios.push(gpio_number)
    @@valves.push(self)
    @@valves_all[@gpio_number] = self
    @@valves_closed[@gpio_number] = self
  end


  def set(value)
    stdin, stdout, stderr = Open3.popen3("fast-gpio set #{@gpio_number} #{value}")
    if stderr.gets
      raise(OnionGpioWrapperError, stderr.gets)
    end
    
    if self.vaule == 0
      @@valves_closed.delete(@gpio_number) if @@valves_closed.has_key?(@gpio_number)
      @@valves_opened[@gpio_number] = self
    end
    
    if self.vaule == 1
      @@valves_opened.delete(@gpio_number) if @@valves_opened.has_key?(@gpio_number)
      @@valves_closed[@gpio_number] = self
    end
    
    value == self.value # return true/false
  end

  def get
    stdin, stdout, stderr = Open3.popen3("fast-gpio read #{@gpio_number}")
    if stderr.gets
      raise(OnionGpioWrapperError, stderr.gets)
    end
    status = stdout.gets.to_s
    status.split.last
  end

  def open
    set(0)
  end

  def close
    set(1)
  end

  def is_closed?
    0 == self.get
  end

  def is_opened?
    1 == self.get
  end

  def value(value=nil)
    if value.nil?
      get()
    else
      set(value)
    end
  end

end
