require 'socket'

class GoFishClient
  attr_reader :socket

  def initialize(address: 'localhost', port: 3336)
    @socket = TCPSocket.new(address, port)
  end

  def close
    socket.close
  end
end
