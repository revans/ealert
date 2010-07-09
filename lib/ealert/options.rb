module EAlert
  class Options
    
    def self.parse(args)
      options = OpenStruct.new
      options.library       = []
      options.inplace       = false
      options.encoding      = "utf8"
      options.transfer_type = :auto
      options.verbose       = false
      
      opts = ::OptionParser.new do |opts|
        opts.on('-g', '--generate-config', "Generate the config file.") do
          ::EAlert::Config.generate!
        end
        
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
        
        opts.on_tail("-v", "--version", "Show version") do
          puts ::EAlert.version
          exit
        end
      end
      
      opts.parse!(args)
      options
    end
    
  end
end