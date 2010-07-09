module EAlert
  class Config
    class << self
      
      ##
      # Generate the yaml file that will be used to stream tweets
      #
      def generate!
        file      = File.join(File.expand_path(File.dirname(__FILE__)), '../config/stream.yaml')
        write_to  = File.join(File.expand_path("~"), '.stream.yaml')
        
        File.open(write_to, 'w+') { |f| f.write(File.read(file).chomp!) }
      end
      
    end
  end
end