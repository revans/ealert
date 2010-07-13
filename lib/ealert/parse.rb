module EAlert
  class Parse
    class << self
    
      
      def json(tweet)
        twit = ::Yajl::Parser.new(:symbolize_keys => true).parse(tweet)
      rescue Exception => e
        raise StandardError.new("\n\nParsing failed. Was trying to parse:\n#{tweet.inspect}\n\nEncountered the following error: #{e.backtrace}\n\n")
      end
      
      
    end
  end
end