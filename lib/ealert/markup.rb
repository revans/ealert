module EAlert
  class Markup
    
    def self.to_html(tweet)
      <<-HTML
<div class="tweet">
  <div class='avatar'>
    #{tweet[:user][:profile_image_url]}
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