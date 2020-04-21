require 'i2c/drivers/ss1602'
require 'dht-sensor-ffi'

display = I2C::Drivers::SS1602::Display.new('/dev/i2c-1', 0x27)

while true
  sensor = DhtSensor.read(4,22)
  regen = `sudo python /home/marvin/Projekt/wetterstation-raspberry-pi/src/regen.py`
  display.clear
  display.text("Temp: #{sensor.temperature.to_i.to_s}*C", 0)
  display.text("Luftf: #{sensor.humidity.to_i.to_s}%", 1)
  sleep(5)
  display.clear
  display.text(regen.to_s, 0)
  sleep(5)
end
