require 'socket'

class GoFishServer
  attr_reader :server

  def port_number
    3336
  end

  def start
    @server = TCPServer.new(port_number)
    puts "Server started - port: #{port_number}"
  end

  def stop
    if server
      puts 'Server stopped'
      server.close
    end
  end

  def accept_connection
    # accept_nonblock
    # store accepted client
    # handle exception with rescue
  end
end
