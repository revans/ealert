module EAlert
  class Config
    class << self
      
      ##
      # Generate the yaml file that will be used to stream tweets
      #
      def generate!
        file      = File.join(File.expand_path(File.dirname(__FILE__)), '../config/events.yaml')
        `mkdir -p #{::EAlert::EVENT_DIR}` unless File.exists?(::EAlert::EVENT_DIR)
        write_to  = File.join(::EAlert::EVENT_DIR, 'events.yaml')
        File.open(write_to, 'w+') { |f| f.write(File.read(file)) }
      end
      
    end
  end
end