module EAlert
  class TwitterFilter
    
    
    ##
    # By Keywords
    #
    def self.by_keywords(keywords, auth=[])
      file      = File.dirname(__FILE__) + '/tweets' 
      filters   = keywords.split(',').collect! { |w| w.strip }.join(',') # TODO: Sanitize
      filename  = keywords.split(',').collect! { |w| w.strip }.join('-')
  
      EventMachine.run do
        http = ::EventMachine::HttpRequest.new("http://stream.twitter.com/1/statuses/filter.json").get(
          :head   => {'authorization' => auth},
          :query  => {:track          => filters}
        )
        http.stream do |chunk| 
          # ::EventStreamer::Parser.json(chunk)
          File.open(File.join(file,"#{Date.today.to_s}_#{filename}.json"), 'a+') { |f| f.write(chunk) }
        end
      end
    
    end
    
    
  end
end