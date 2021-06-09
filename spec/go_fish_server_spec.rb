require_relative '../lib/go_fish_server.rb'
require_relative '../lib/go_fish_client.rb'

describe 'GoFishServer' do
  let(:server) { GoFishServer.new }

  before(:each) do
    server.start
  end

  after(:each) do
    server.stop
  end

  it 'returns the port number' do
    expect(server.port_number).to eq 3336
  end

  context '#accept_connection' do
    it 'accepts a client' do
      cient = GoFishClient.new
      server.accept_connection
      expect(server.clients.count).to eq 1
    end

    it 'rescue no client error' do
      expect(server.accept_connection).to eq 'No client to accept'
    end
  end
end
