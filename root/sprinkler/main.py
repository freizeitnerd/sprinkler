#!/usr/bin/python
from valve import Valve
import time, json

CONFIG = json.load(open('config.json'))

valves = []
valveNames = CONFIG['valveNames']
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
