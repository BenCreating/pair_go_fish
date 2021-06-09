require 'socket'

class GoFishServer
  attr_reader :server

  def port_number
    3336
  end

  def start
    @server = TCPServer.new(port_number)
  end

  def stop
    server.close if server
  end
end
