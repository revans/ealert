module EAlert
  class WebSocketServer
    
    def self.start(channel, host='0.0.0.0', port=9393, debug=false)
      @channel = channel
      
      ::EventMachine::WebSocket.start(:host => host, :port => port, :debug => debug) do |ws|
        ws.onopen {
          @sid = @channel.subscribe { |msg| ws.send(msg) }
        }

        ws.onmessage { |msg|
          @channel.push "<#{@sid}>: #{msg}"
        }

        ws.onclose {
          @channel.unsubscribe(@sid)
        }
      end
      STDOUT.puts "A Web Socket Server was started at #{host}:#{port}."
    end
    
  end
end