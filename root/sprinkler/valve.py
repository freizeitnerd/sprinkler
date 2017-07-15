#!/usr/bin/python
import onionGpio, os

class Valve:
  totalCount = 0

  def __init__(self, name, gpioNumber):
    print 'Init valve "' + name + '" at GPIO', gpioNumber
    self.gpioNumber = gpioNumber
    self.name = name
    self.gpio = onionGpio.OnionGpio(gpioNumber)
    self.status = self.gpio.setOutputDirection(1)
    Valve.totalCount += 1

  def open(self):
    print 'open', self.name, "at GPIO",self.gpioNumber
    self.gpio.setOutputDirection(0)

  def close(self):
    print 'close', self.name
    self.gpio.setOutputDirection(1)

