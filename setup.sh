#!/bin/bash
gpioNumber="0 2 3 11 18 45 46"   # attention redundant with config.json #TODO: Parse config.json

opkg update

opkg install git git-http ca-bundle

opkg install ruby-openssl
opkg install arduino-dock-2
opkg install ruby
opkg install ruby-gems
opkg install ruby-yaml
opkg install ruby-cgi
opkg install ruby-enc-extra
opkg install ruby-datetime
opkg install ruby-json
opkg install ruby-pstore

gem install logger
gem install parse-cron
gem install omega2_gpio --pre

# copy example configuration, if no configuration exists
if [ ! -e config/config.json ]
then
    echo "Init default configuration"
    cp config/example/config.json config/config.json
fi
if [ ! -e config/settings.json ]
then
    echo "Init default setting"
    cp config/example/settings.json config/settings.json
fi

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