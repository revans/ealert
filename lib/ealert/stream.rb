module EAlert
  class Stream
    
    
    ##
    # Event
    # 
    # @param  [String]
    # @api    private
    #
    def self.event(name)      
      config = File.open(File.join(::EAlert::EVENT_DIR, 'events.yaml')) { |event| YAML::load(event) }
      fork_event(config[name.to_s], name)
    end
    
    
    # Config:: {"mongodb"=>{"port"=>27017, "database"=>"event_alert", "host"=>"localhost", "collection"=>"disasters"}, "calais_license"=>"tjefdbrxgpqsj6e69uwfzf2j", "twitter"=>{"pass"=>"demo", "login"=>"demo"}, "keywords"=>"hurricane, hurricanes, #hurricane, #hurricanes"} :: Hash
    
    
    
    
    ##
    # Fork Event
    #
    # @param  [Object, String]
    # @api    private
    #
    def self.fork_event(config, event_name)
      auth  = [config['twitter']['login'], config['twitter']['pass']]
      
      pid   = fork do
        ::Signal.trap('HUP', 'IGNORE')
        ::EAlert::TwitterFilter.by_keywords(config['keywords'], event_name, auth)
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
      File.open(File.join(::EAlert::EVENT_DIR, "#{event}.pid"), 'w+') { |f| f.write(pid) }
    end
    
  end
end
