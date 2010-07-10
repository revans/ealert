module EAlert
  class Options
    
    def self.parse(args)
      options = OpenStruct.new
      
      opts = ::OptionParser.new do |opts|
        opts.on('-g', '--generate-config', "Generate the config file.") do
          ::EAlert::Config.generate!
        end

        event_list = ::EAlert::Config.events.join(', ')
        opts.on('--event EVENT', ::EAlert::Config.events, "Select an event to stream", "  (#{event_list})") do |event|
          options.event = event
        end
        
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
        
        opts.on_tail("-v", "--version", "Show version") do
          puts "Event Streamer is currently at version #{::EAlert.version}"
          exit
        end
      end
      
      opts.parse!(args)
      options
    end
    
  end
end
