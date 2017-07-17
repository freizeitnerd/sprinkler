require "open3"
require "yaml/store" # https://robm.me.uk/ruby/2014/01/25/pstore.html

class Valve
  @@mock = false
  @@gpios = []
  @@valves = []
  @@valves_all = {}
  @@valves_opened = {}
  @@valves_closed = {}
  @@mock_value = {}
  @@log = YAML::Store.new("./data/valves_log.yml")

  if ENV.has_key?("gpio_mode") && ENV["gpio_mode"] == "mock"
    @@mock = true
  end


  def initialize(gpio_number, name)
    @gpio_number = gpio_number
    @name = name

    if @@mock
      puts "Init valve '#{@name}' at Fake-GPIO#{@gpio_number} and mock all interactions as valid"
    else
      #puts "Init valve '#{@name}' at GPIO#{@gpio_number}"
      stdin, stdout, stderr = Open3.popen3("fast-gpio set-output #{@gpio_number}")
      if stderr.gets
        raise(OnionGpioWrapperError, stderr.gets)
      end
    end

    @@gpios.push(@gpio_number)
    @@valves.push(self)
    @@valves_all[@gpio_number] = self

    self.close
  end


  def set(v)
    #puts "Set value for GPIO #{@gpio_number} to #{v} as #{self.inspect}"

    #puts @@log.transaction { @@log.fetch(:nonexistent_key, "default value") }

    unless @@log.transaction { @@log.fetch(@gpio_number, nil) }
      puts "Init @gpio_number in @@log"
      @@log.transaction do
        @@log[@gpio_number] = {last_opened: Time.new(2000,1,1) }
      end
    end

    if @@mock
      #puts "Mock value for GPIO #{@gpio_number} to #{v}"
      @@mock_value[@gpio_number] = v
    else
      stdin, stdout, stderr = Open3.popen3("fast-gpio set #{@gpio_number} #{v}")
      if stderr.gets
        raise(OnionGpioWrapperError, stderr.gets)
      end
    end

    #puts "self.value for GPIO #{@gpio_number} is #{self.value}"

    if self.value == 0 # opened valve
      #puts "+ Add GPIO #{@gpio_number} to @@valves_opened as #{self.inspect}"
      @@valves_closed.delete(@gpio_number) if @@valves_closed.has_key?(@gpio_number)
      @@valves_opened[@gpio_number] = self
      @@log.transaction do
        @@log[@gpio_number][:last_opened] = Time.now
      end
    end
    
    if self.value == 1 # closed valve
      #puts "- Add GPIO #{@gpio_number} to @@valves_closed as #{self.inspect}"
      @@valves_opened.delete(@gpio_number) if @@valves_opened.has_key?(@gpio_number)
      @@valves_closed[@gpio_number] = self
      #puts "@@valves_closed #{@@valves_closed.inspect}"
    end
    
    v == value # return true/false
  end


  def get
    status = ""
    if @@mock
      status = "mocked #{@@mock_value[@gpio_number]}"
    else
      stdin, stdout, stderr = Open3.popen3("fast-gpio read #{@gpio_number}")
      if stderr.gets
        raise(OnionGpioWrapperError, stderr.gets)
      end
      status = stdout.gets.to_s
    end
    status.split.last.to_i
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
      get
    else
      set(value)
    end
  end


  def valves
    @@valves
  end


  def valves_all
    @@valves_all
  end


  def valves_opened
    @@valves_opened
  end


  def valves_open # alias
    valves_opened
  end


  def valves_closed
    @@valves_closed
  end


  def valves_close # alias
    valves_closed
  end


  def name
    @name
  end


  def gpio_number
    @gpio_number
  end


  def close_all
    @@valves.each do |valve|
      valve.close
    end
  end

  def log
    @@log
  end
end
