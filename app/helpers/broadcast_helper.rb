module BroadcastHelper
  def broadcast(channel, message)
    message = {:channel => channel, :data => message}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
end