require_relative '../lib/go_fish_server.rb'

describe 'GoFishServer' do
  let(:server) { GoFishServer.new }

  it 'returns the port number' do
    expect(server.port_number).to eq 3336
  end
end
