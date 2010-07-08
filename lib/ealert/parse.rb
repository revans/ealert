module EAlert
  class Parse
    class << self
      
      def json
        json_files.each do |file|
          json_array    = File.open(file).collect { |line| line }
          @parsed_json  = json_array.collect { |json| ::Yajl::Parser.new(:symbolize_keys => true).parse(json) }
        end
        @parsed_json
      end
      
      def json_files 
        Dir.glob(File.join(File.dirname(__FILE__) + '/tweets', '*.json'))
      end
      
    end
  end
end