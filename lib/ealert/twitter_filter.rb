module EAlert
  class TwitterFilter
    
    
    ##
    # By Keywords
    #
    # @param  [String, String, Array]
    # @api    Private
    #
    def self.by_keywords(config, event_name, debug, server)
      filters   = config['keywords'].split(',').collect! { |w| w.strip }.join(',') # TODO: Sanitize
      @store    = ::EAlert::Store.new(config)
      @calais   = ::EAlert::Calais.new(config['calais_license']) if config['calais_license']
      
      ::EventMachine::run {
        @channel  = ::EM::Channel.new if server
        
        stream = ::Twitter::JSONStream.connect(
          :path    => '/1/statuses/filter.json',
          :auth    => "#{config['twitter']['login']}:#{config['twitter']['pass']}",
          :method  => 'POST',
          :content => "track=#{filters}"
        )

        stream.each_item do |item|
          tweet = ::Yajl::Parser.new(:symbolize_keys => true).parse(item)
          tweet[:calais]  = @calais.process_tweet(tweet[:text])
          @store.insert(tweet) # TODO: use em-mongo so we aren't blocking inside the reactor
          
          if server
            @channel.push ::Yajl::Encoder.encode(tweet)
          end
          
          if debug
            $stdout.print "\n#{tweet.inspect}\n\n"
            $stdout.flush
          end
        end

        stream.on_error do |message|
          $stdout.print "\nerror: #{message}\n"
          $stdout.flush
        end

        stream.on_reconnect do |timeout, retries|
          $stdout.print "\nreconnecting in: #{timeout} seconds\n"
          $stdout.flush
        end

        stream.on_max_reconnects do |timeout, retries|
          $stdout.print "\nFailed after #{retries} failed reconnects\n"
          $stdout.flush
        end

        trap('TERM') do  
          stream.stop
          ::EventMachine.stop if ::EventMachine.reactor_running? 
        end
        
        ::EAlert::WebSocketServer.start(@channel) if server
      }
    end
    
    
  end
end