#!/usr/bin/python
import valve
import onionGpio
import time
    
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
    print 'open', self.name, "at GPIO "+self.
    self.gpio.setOutputDirection(0)
  
  def close(self):
    print 'close', self.name
    self.gpio.setOutputDirection(1)

valves = []
valveNames = ['rear1', 'lawn1', 'lawn2', 'front', 'front2', 'rear2', 'tapWater']
gpioNumbers = [0,1,2,3,11,18] # The order asigns valveName to GPIO number

if len(valveNames) > 6:
  print "Only the first 6 named valves will be supported."

for index in range(len(gpioNumbers)):
   #print 'Current valve :', valveNames[index]
   valves.append(Valve(valveNames[index], gpioNumbers[index]))

print Valve.totalCount,'valves attached'

for index in range(len(valveNames)):
  time.sleep(1)
  valves[index].open()
  time.sleep(1)
  valves[index].close()
