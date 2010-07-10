module EAlert
  class Config
    class << self
      
      ##
      # Generate the yaml file that will be used to stream tweets
      #
      def generate!
        file      = File.join(File.expand_path(File.dirname(__FILE__)), '../config/events.yaml')
        `mkdir -p #{::EAlert::EVENT_DIR}` unless File.exists?(::EAlert::EVENT_DIR)
        File.open(config, 'w+') { |f| f.write(File.read(file)) }
      end
      
      
      ##
      # Config
      #
      # @return [Object]
      # @api    private
      #
      def config
        File.join(::EAlert::EVENT_DIR, 'events.yaml')
      end
      
      
      ##
      # Events
      #
      # @return [Array]
      # @api    private
      #
      def events
        @events = []
        File.open(config) { |event| YAML::load(event) }.each { |k,v| @events << k }
        @events
      end
      
    end
  end
end