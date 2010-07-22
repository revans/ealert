module EAlert
  class Config
    class << self
      
      ##
      # Generate the yaml file that will be used to stream tweets
      #
      def generate!
        `mkdir -p #{::EAlert::USER_CONFIG}` unless File.exists?(::EAlert::USER_CONFIG)
        File.open(user_config, 'w+') { |f| f.write(File.read(::EAlert::INTERNAL_CONFIG)) }
      end
      
      
      ##
      # User Config
      #
      # @return [Object]
      # @api    private
      #
      def user_config
        File.join(::EAlert::USER_CONFIG, 'events.yaml')
      end
      
      
      ##
      # Events
      #
      # @return [Array]
      # @api    private
      #
      def events
        return [] unless File.exists?(user_config)
        @events = []
        File.open(user_config) { |event| YAML::load(event) }.each { |k,v| @events << k }
        @events
      end
      
    end
  end
end