require_relative '../lib/go_fish_server.rb'

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

  it 'accepts a client' do
    expect(server.accept_connection).to eq 'accepted'
  end
end
