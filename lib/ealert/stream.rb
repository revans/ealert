module EAlert
  class Stream
    
    def self.event(name)      
      @config = ::EAlert::Config.events
      @config[name.to_s]
    end
    
  end
end


# keywords = ARGV.first
#   location = ARGV.last
#   pid = fork do
#     Signal.trap('HUP', 'IGNORE')
#     ::EAlert::TwitterFilter.by_keywords(keywords, location, ['revans', ''])
#   end
#   Process.detach(pid)
#   puts "Setup as a background process with PID: #{pid}."