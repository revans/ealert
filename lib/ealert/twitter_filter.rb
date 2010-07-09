module EAlert
  class TwitterFilter
    
    
    ##
    # By Keywords
    #
    def self.by_keywords(keywords, location, auth=[])
      file      = File.expand_path(location) + '/tweets' 
      filters   = keywords.split(',').collect! { |w| w.strip }.join(',') # TODO: Sanitize
      filename  = keywords.split(',').collect! { |w| w.strip }.join('-')

      `mkdir -p #{file}` unless File.exists?(file)
      
      STDOUT.puts "Going to start streaming tweets that talk about #{filters} and store them in this file: #{file}."
  
      EventMachine.run do
        http = ::EventMachine::HttpRequest.new("http://stream.twitter.com/1/statuses/filter.json").get(
          :head   => {'authorization' => auth},
          :query  => {:track          => filters}
        )
        http.stream do |chunk| 
          File.open(File.join(file,"#{Date.today.to_s}_#{filename}.json"), 'a+') { |f| f.write(chunk) }
        end
      end
    
    end
    
    
  end
end