module EAlert
  class TwitterFilter
    
    
    ##
    # By Keywords
    #
    # @param  [String, String, Array]
    # @api    Private
    #
    def self.by_keywords(config, event_name)
      username, password  = config['twitter']['login'], config['twitter']['pass']
      filters             = config['keywords'].split(',').collect! { |w| w.strip }.join(',') # TODO: Sanitize
      @store              = ::EAlert::Store.new(config)

      uri = URI.encode("http://#{username}:#{password}@stream.twitter.com/1/statuses/filter.json?track=#{filters}")
      ::Yajl::HttpStream.post(uri, :symbolize_keys => true) do |tweet|
        store.insert(tweet)
      end
    end
    
    
  end
end