module EAlert
  class TwitterFilter
    
    
    ##
    # By Keywords
    #
    # @param  [String, String, Array]
    # @api    Private
    #
    def self.by_keywords(config, event_name, debug)
      # auth    = [config['twitter']['login'], config['twitter']['pass']]
      filters = config['keywords'].split(',').collect! { |w| w.strip }.join(',') # TODO: Sanitize
      @store  = ::EAlert::Store.new(config)
      @calais = ::EAlert::Calais.new(config['calais_license']) if config['calais_license']
      
      
      ::EventMachine::run {
        stream = ::Twitter::JSONStream.connect(
          :path    => '/1/statuses/filter.json',
          :auth    => "#{config['twitter']['login']}:#{config['twitter']['pass']}",
          :method  => 'POST',
          :content => "track=#{filters}"
        )

        stream.each_item do |item|
          fork do
            tweet = ::Yajl::Parser.new(:symbolize_keys => true).parse(item)
            tweet[:calais]  = @calais.process_tweet(tweet[:text])
            @store.insert(tweet)
          end
          
          if debug
            $stdout.print "\nitem: #{item}\n"
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

        trap('TERM') {  
          stream.stop
          ::EventMachine.stop if ::EventMachine.reactor_running? 
        }
      }










      # uri = URI.encode("http://#{auth.join(':')}@stream.twitter.com/1/statuses/filter.json?track=#{filters}")
      # url = URI.parse(uri)
      # 
      # STDOUT.puts "URL: #{url.inspect}" if debug
      # 
      # ::Yajl::HttpStream.get(url, :symbolize_keys => true) do |tweet|
      #   if debug
      #     STDOUT.puts "\nTweet: #{tweet.inspect}\n\n"
      #     STDOUT.flush
      #   end
      #   @store.insert(tweet)
      #   fork do
      #     tweet[:calais]  = @calais.process_tweet(tweet[:text]) if @calais
      #     @store.insert(tweet)
      #   end
      # end
      
      
      
      
      
      
      
      # ::EventMachine.run do
      #   http = ::EventMachine::HttpRequest.new('http://stream.twitter.com/1/statuses/filter.json').post(
      #           :head     => {'authorization' => auth},
      #           :query    => {:track          => filters},
      #           :timeout  => 10)
      #   
      #   STDOUT.puts "\n\nHTTP: #{http.inspect}\n\n" if debug
      # 
      #   buffer = ''
      #   http.stream do |chunk|
      #     buffer += chunk
      #     while line = buffer.slice!(/.+\r?\n/)
      #       fork do 
      #         tweet           = ::Yajl::Parser.new(:symbolize_keys => true).parse(line)
      #         tweet[:calais]  = @calais.process_tweet(tweet[:text])
      #         @store.insert(tweet)
      #         STDOUT.puts "\n#{tweet.inspect}\n\n" if debug
      #       end
      #     end
      #   end
      # end
      rescue Exception => e
        STDOUT.puts "\n\nException: #{e.backtrace}\n\n"
    end
    
    
  end
end