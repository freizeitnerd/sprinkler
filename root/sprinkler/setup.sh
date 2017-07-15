#!/bin/bash
gpioNumber="0 1 2 3 11 18 45 46"   # attention redundant with config.json #TODO: Parse config.json

opkg update
opkg install python-light
opkg install vsftpd
opkg install pyOnionGpio
opkg install git
opkg install git-http

# Set GPIOs
omega2-ctrl gpiomux set i2c gpio
omega2-ctrl gpiomux set uart0 gpio
omega2-ctrl gpiomux set uart1 gpio
omega2-ctrl gpiomux set uart2 gpio
omega2-ctrl gpiomux set pwm0 gpio
omega2-ctrl gpiomux set pwm1 gpio
omega2-ctrl gpiomux set i2s gpio

for gpioNumber in $gpioNumber
do
  echo "GPIO ${gpioNumber} set to high output"
  fast-gpio set-output $gpioNumber
  fast-gpio set $gpioNumber 1
  gpioctl dirout $gpioNumber
  gpioctl dirout-high $gpioNumber
done
omega2-ctrl gpiomux get