module EAlert
  class TwitterFilter
    
    
    ##
    # By Keywords
    #
    # @param  [String, String, Array]
    # @api    Private
    #
    def self.by_keywords(config, event_name, debug)
      auth    = [config['twitter']['login'], config['twitter']['pass']]
      filters = config['keywords'].split(',').collect! { |w| w.strip }.join(',') # TODO: Sanitize
      @store  = ::EAlert::Store.new(config)
      @calais = ::EAlert::Calais.new(config['calais_license'])
      
      ::EventMachine.run do
        http = ::EventMachine::HttpRequest.new('http://stream.twitter.com/1/statuses/filter.json').get(
                :head     => {'authorization' => auth},
                :query    => {'track'         => filters},
                :timeout  => 10)
                
        buffer = ''
        http.stream do |chunk|
          buffer += chunk
          while line = buffer.slice!(/.+\r?\n/)
            fork do 
              tweet           = ::EAlert::Parse.json(line)
              tweet[:calais]  = @calais.process_tweet(tweet[:text])
              @store.insert(tweet)
              STDOUT.puts "\n#{tweet.inspect}\n\n" if debug
            end
          end
        end
      end

    end
    
    
  end
end