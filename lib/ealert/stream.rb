module EAlert
  class Stream


    ##
    # Kill Event
    #
    # @param  [String]
    # @api    private
    #
    def self.kill_event(name)
      pid = File.read(File.join(::EAlert::USER_CONFIG, "pids/#{name}.pid")) 
      `kill -9 #{pid}`
    end
    
    
    ##
    # Event
    # 
    # @param  [String]
    # @api    private
    #
    def self.event(options)  
      STDOUT.puts "\n\n#{options.inspect}\n\n"    
      name    = options.event
      config  = File.open(File.join(::EAlert::USER_CONFIG, 'events.yaml')) { |event| YAML::load(event) }
      fork_event(config[name.to_s], name, options)
    end
    
    
    ##
    # Fork Event
    #
    # @param  [Object, String]
    # @api    private
    #
    def self.fork_event(config, event_name, options)
      auth  = [config['twitter']['login'], config['twitter']['pass']]
      
      pid   = fork do
        ::Signal.trap('HUP', 'IGNORE')
        ::EAlert::TwitterFilter.by_keywords(config, event_name, options)
      end
      
      ::Process.detach(pid)
      write_pid(event_name, pid)
    end
    
    
    ##
    # Write PID
    #
    # @param  [String, Integer]
    # @api    private
    #
    def self.write_pid(event, pid)
      file = File.join(::EAlert::USER_CONFIG, "pids")
      system("mkdir -p #{file}") unless File.exists?(file)
      File.open(File.join(file, "#{event}.pid"), 'w+') { |f| f.write(pid) }
    end
    
  end
end
