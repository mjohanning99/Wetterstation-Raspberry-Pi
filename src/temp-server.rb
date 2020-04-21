#!/usr/bin/ruby

require 'dht-sensor-ffi' # For reading the DHT22 data
require 'socket' # For creating an HTTP server
server = TCPServer.new 80 # Create a new TCP server on port 80

while session = server.accept
  regen = `sudo python /home/marvin/Projekt/wetterstation-raspberry-pi/src/regen.py`

  request = session.gets
  puts request

  session.print "HTTP/1.1 200\r\n" # To tell the server we're using HTTP v. 1.1 with response code 200
  session.print "Content-Type: text/html\r\n" # To tell the server it's serving HTML 
  session.print "\r\n" # A new line

  sensor = DhtSensor.read(4,22) # Get the data from the DHT22 from pinout 4
  session.print "<meta http-equiv='refresh' content='2' />" # For refreshing the page every two seconds to get new temperature data

  session.print "<h2>Raspberry Pi Wetterstation</h2>"
  session.print "<hr>"

  session.print "Das aktuelle Datum und die aktuelle Uhrzeit betraegt: #{Time.now}" # Print current time
  session.print "<br>" 

  session.print "Temperatur: #{sensor.temp.to_i}*C" # Print current temperature
  session.print "<br>"
  session.print "Luftfeuchtigkeit: #{sensor.humidity.to_i}%" # Print current humidity

  session.print "<br>"
  session.print "Regen: #{regen}"
  
  session.close
end
