module EAlert
  module Version
    MAJOR,MINOR,TINY = File.read(File.join(File.dirname(__FILE__), '../../VERSION')).split('.')
    STRING = [MAJOR, MINOR, TINY].join('.')
  end
  
  def self.version
    Version::STRING
  end
end