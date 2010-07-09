module EAlert
  class Options
    
    def self.parse(args)
      options = OpenStruct.new
      
      opts = ::OptionParser.new do |opts|
        opts.on('-g', '--generate-config', "Generate the config file.") do
          ::EAlert::Config.generate!
        end
        
        opts.on('-r', '--run event', 'Run all events in your YAML file, or pick a specific one.') do |e|
          options.event = e
        end
        
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
        
        opts.on_tail("-v", "--version", "Show version") do
          puts "Event Streamer is currently at version #{::EAlert.version}."
          exit
        end
      end
      
      opts.parse!(args)
      options
    end
    
  end
end