require 'faye'
Faye::WebSocket.load_adapter('thin')
faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 45)

faye_server.on(:handshake) do |client_id|
  puts "[Handshake] #{client_id}"
end

faye_server.on(:subscribe) do |client_id, channel|
  puts "[Subscribe] #{client_id}: #{channel}"
end

faye_server.on(:disconnect) do |client_id|
  puts "[Disconnect] #{client_id}"
end

run faye_server