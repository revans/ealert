module EAlert
  class Calais
    
    def initialize(license)
      @license = license
    end

    def process_tweet(tweet)
      data = get_info(tweet)
      {
        :keywords     => process_keywords(data.categories),
        :language     => data.language,
        :geographies  => process_geographies(data.geographies)
      }
    end
    
    private
      
      def get_info(tweet)
        ::Calais.process_document(
            :content      => tweet,
            :content_type => :html, 
            :license_id   => @license
        )
      end
      
      def process_keywords(categories)
        categories.collect do |category|
          {:name => category.name, :score => category.score}
        end
      end
      
      
      def process_geographies(geographies)
        geographies.collect do |geography|
          {:place           => geography.name,
           :latitude        => geography.attributes['latitude'],
           :longitude       => geography.attributes['longitude'],
           :country         => geography.attributes['containedbycountry'],
           :place_shortname => geography.attributes['shortname'] }
        end
      end
        

  end
end