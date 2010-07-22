module EAlert
  class Markup
    
    def self.to_html(tweet)
      <<-HTML
<div class="tweet">
  <div class='avatar'>
    #{tweet[:user][:screen_name]}
  </div>
  <div class='tweet_text'>
    #{tweet[:text]}
  </div>
</div>
      HTML
    end
    
  end
end