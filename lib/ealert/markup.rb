module EAlert
  class Markup
    
    def self.to_html(tweet)
      <<-HTML
<div class="tweet">
  <div class='avatar'>
    <img src="#{tweet[:user][:profile_image_url]}" alt="#{tweet[:user][:screen_name]} Avatar" />
  </div>
  <div class='tweet_text'>
    <p>#{tweet[:text]}</p>
    <p>#{tweet[:user][:screen_name]} tweeted this on #{tweet[:created_at]}</p>
  </div>
</div>
      HTML
    end
    
  end
end