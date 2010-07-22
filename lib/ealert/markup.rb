module EAlert
  class Markup
    
    def self.to_html(tweet)
      <<-HTML
<div class="tweet">
  <div class='avatar'>
    <img src="#{tweet[:user][:profile_image_url]}" alt="#{tweet[:user][:screen_name]} Avatar" />
  </div>
  <div class='tweet_text'>
    <p>#{linkify(tweet[:text])}</p>
    <p>#{tweet[:user][:screen_name]} tweeted this on #{tweet[:created_at]}</p>
  </div>
</div>
      HTML
    end
    
    private
      
      
      def self.linkify(text)
        text.split(' ').each do |word|          
          if word =~ /^http|https|www\./
            word.gsub!(word.to_s, "<a href='#{word}'>#{word}</a>")
          elsif word =~ /^@\w/
            name = word.to_s.gsub(/^@/, '')
            word.gsub!(word.to_s, "<a href='http://www.twitter.com/#{name}>#{word}</a>")
          end
        end.join(' ')
      end
    
  end
end