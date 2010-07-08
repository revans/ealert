module EAlert
  class Store
    class << self
      
      def insert(col, hash)
        db.collection(col).insert(hash.merge(:created_on => Time.now.utc))
      end
    
      # TODO: determine the hash to be upserted (id of the Tweet Object, id of the Calais Object)
      #       the type is the disaster type or event type
      def update(col, hash, type)
        db.collection(col).update(hash.merge(:updated_on => Time.now.utc), {'$inc' => {type.to_s => 1}}, :upsert => true)
      end
      
      private
      
        def db
          @db ||= ::Mongo::Connection.new(::EAlert::HOST, ::EAlert::PORT).db(::EAlert::DATABASE)
        end
      
    end
  end
end