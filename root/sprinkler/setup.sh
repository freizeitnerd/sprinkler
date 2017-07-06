#!/path/to/shell

# Set GPIOs
omega2-ctrl gpiomux set i2c gpio
omega2-ctrl gpiomux set uart0 gpio
omega2-ctrl gpiomux set uart1 gpio
omega2-ctrl gpiomux set uart2 gpio
omega2-ctrl gpiomux set pwm0 gpio
omega2-ctrl gpiomux set pwm1 gpio
omega2-ctrl gpiomux set i2s gpio

fast-gpio set-output 0
fast-gpio set-output 1
fast-gpio set-output 2
fast-gpio set-output 3
fast-gpio set-output 11
fast-gpio set-output 18
