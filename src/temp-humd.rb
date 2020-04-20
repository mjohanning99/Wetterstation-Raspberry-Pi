require 'dht-sensor-ffi'
require 'socket'
server = TCPServer.new 5678

while session = server.accept
  request = session.gets
  puts request

  val = DhtSensor.read(4,22)
  session.print "HTTP/1.1 200\r\n"
  session.print "Content-Type: text/html\r\n"
  session.print "\r\n"
  session.print "<h2>Raspberry Pi Wetterstation</h2>"
  session.print "Das aktuelle Datum und die aktuelle Uhrzeit betraegt: #{Time.now}"
  session.print "<br>"
  session.print "Temperatur: #{val.temp.to_i}*C"
  session.print "<br>"
  session.print "Luftfeuchtigkeit: #{val.humidity.to_i}%"
  
  session.close
end
