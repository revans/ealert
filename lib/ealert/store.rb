module EAlert
  class ConnectionError < StandardError; end
  class Store
    
    def initialize(config)
      @db = ::Mongo::Connection.new(config['mongodb']['host'],
                                    config['mongodb']['port']).db(
                                    config['mongodb']['database']).collection(
                                    config['mongodb']['collection'])
      # rescue Exception => e
      #   raise ::EAlert::ConnectionError.new("There was an error connecting to the Mongo database.")
    end
    
    def insert(hash)
      @db.insert(hash.merge(:created_on => Time.now.utc))
    end
  
    # TODO: determine the hash to be upserted (id of the Tweet Object, id of the Calais Object)
    #       the type is the disaster type or event type
    def update(hash, type)
      @db.update(hash.merge(:updated_on => Time.now.utc), {'$inc' => {type.to_s => 1}}, :upsert => true)
    end


  end
end