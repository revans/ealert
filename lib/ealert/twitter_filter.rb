module EAlert
  class TwitterFilter
    
    
    ##
    # By Keywords
    #
    # @param  [String, String, Array]
    # @api    Private
    #
    def self.by_keywords(config, event_name)
      auth      = [config['twitter']['login'], config['twitter']['pass']]
      file      = File.expand_path(::EAlert::USER_CONFIG) + '/tweets' 
      filters   = config['keywords'].split(',').collect! { |w| w.strip }.join(',') # TODO: Sanitize

      `mkdir -p #{file}` unless File.exists?(file)
  
      EventMachine.run do
        http = ::EventMachine::HttpRequest.new("http://stream.twitter.com/1/statuses/filter.json").get(
          :head   => {'authorization' => auth},
          :query  => {:track          => filters}
        )
        http.stream do |chunk| 
          File.open(File.join(file,"#{Date.today.to_s}_#{event_name}.json"), 'a+') { |f| f.write(chunk) }
          # a = ::EAlert::Parse.json(chunk, config)
          # STDOUT.puts(a)
        end
      end
    
    end
    
    
  end
end