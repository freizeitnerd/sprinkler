#!/usr/bin/python
from valve import Valve
import time, json

CONFIG = json.load(open('config.json'))

print 'Run boot script'

for index in range(len(CONFIG['gpioNumbers'])):
   Valve(CONFIG['valveNames'][index], CONFIG['gpioNumbers'][index]).close()
