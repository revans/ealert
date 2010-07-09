module EAlert
  class Store
    class << self
      
      def insert(conn, hash)
        db(conn).insert(hash.merge(:created_on => Time.now.utc))
      end
    
      # TODO: determine the hash to be upserted (id of the Tweet Object, id of the Calais Object)
      #       the type is the disaster type or event type
      def update(conn, hash, type)
        db(conn).update(hash.merge(:updated_on => Time.now.utc), {'$inc' => {type.to_s => 1}}, :upsert => true)
      end
      
      private
      
        def db(conn)
          @db ||= ::Mongo::Connection.new(conn[:host], conn[:port]).db(conn[:database]).collection(conn[:collection])
        end
      
    end
  end
end