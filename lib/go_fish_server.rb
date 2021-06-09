require 'socket'

class GoFishServer
  attr_reader :server, :clients

  def port_number
    3336
  end

  def initialize
    @clients = []
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
    client = server.accept_nonblock
    clients << client
    puts 'client connected'
  rescue IO::WaitReadable
    'No client to accept'
  end

  def recieve_message(client)
    sleep(0.1)
    message = client.read_nonblock(1000).chomp
    message
  rescue IO::WaitReadable
    'No message'
  end

  def send_message(client, message)
    client.puts message
  end
end
