module EAlert
  class Parse
    class << self
    
      
      def json(chunk, config)
        store = ::EAlert::Store.new(config)
        
        if chunk.is_a?(Array)
          chunk.each do |tweet|
            parsing(tweet, store)
          end
        else
          parsing(chunk, store)
        end
      end
      
      
      
      def parsing(tweet, store)
        twit = ::Yajl::Parser.new(:symbolize_keys => true).parse(tweet)
        store.insert(twit)
      end
      
      
    end
  end
end