module EAlert
  class Stream
    
    def self.event(name)
      @config = ::YAML.load(File.join(::EAlert::EVENT_DIR, 'events.yaml'))[name.to_sym]
      @config
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