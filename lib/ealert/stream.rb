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
      Process.kill("TERM", pid) if pid
    end
    
    
    ##
    # Event
    # 
    # @param  [String]
    # @api    private
    #
    def self.event(options)  
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
      auth      = [config['twitter']['login'], config['twitter']['pass']]
      debug     = !!options.debug
      server    = !!options.server
      
      parent_pid = fork do
        Process.setsid
        child_pid = fork do
          ::Signal.trap('HUP', 'IGNORE')
          unless debug
            STDIN.reopen    '/dev/null'
            STDOUT.reopen   '/dev/null', 'a'
            STDERR.reopen   STDOUT
          end
          ::EAlert::TwitterFilter.by_keywords(config, event_name, debug, server)
        end
        Process.detach(child_pid)
        write_pid(event_name, child_pid)
      end
      
      ::Process.detach(parent_pid)
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
