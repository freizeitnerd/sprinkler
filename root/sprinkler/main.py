#!/usr/bin/python
from valve import Valve
import time, json

CONFIG = json.load(open('config.json'))

ledTriggerPath = r'/sys/class/leds/omega2p\:amber\:system/trigger'
print ledTriggerPath
## Set the Omega LED trigger to "timer" so that it blinks
with open(ledTriggerPath, "w") as trigger:
  trigger.write("heartbeat")

valves = []
valveNames = CONFIG['valveNames']
gpioNumbers = CONFIG['gpioNumbers'] # The order assigns valveName to GPIO number

if len(valveNames) > len(gpioNumbers):
  print "Only the first",len(gpioNumbers),"named valves will be supported."

for index in range(len(gpioNumbers)):
   #print 'Current valve :', valveNames[index]
   valves.append(Valve(valveNames[index], gpioNumbers[index]))

print Valve.totalCount,'valves attached'

for index in range(len(valveNames)):
  time.sleep(1)
  valves[index].open()
  time.sleep(1)
  valves[index].close()
