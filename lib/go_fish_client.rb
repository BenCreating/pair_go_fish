require 'socket'

class GoFishClient
  attr_reader :socket

  def initialize(address: 'localhost', port: 3336)
    @socket = TCPSocket.new(address, port)
  end

  def close
    socket.close
  end

  def read_message
    sleep(0.1)
    socket.read_nonblock(1000).chomp
  rescue IO::WaitReadable
    'No message'
  end
end
