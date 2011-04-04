var TwitterParsing = {
  
  covertToHtml : function(text) {
    var tweet = jQuery.parseJSON(text);
    var html = '<div class="tweet"><div class="avatar">';
    html += '<img src="' + tweet.user.profile_image_url + '" alt="' + tweet.user.screen_name + ' Avatar" /></div>';
    html += '<div class="tweet_text">';
    html += '<p>' + this.filterTweetForLinks(tweet.text) + '</p>';
    html += '<p class="tweeter"><a href="http://www.twitter.com/' + tweet.user.screen_name + '" target="_new">' + tweet.user.screen_name + '</a> tweeted this ' + this.convertToDateTime(tweet.created_at) + '.</p>';
    html += '</div></div>';
    return html
  },
  
  filterTweetForLinks : function(text) {
    var tweet_text = text.toString().replace( /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig, '<a href="$1" target="_new">$1</a>' ).replace( /(^|\s)@(\w+)/ig, '<a href="http://www.twitter.com/$2" target="_new">@$2</a>' ).replace( /[#]+[A-Za-z0-9-_]+/ig, function(t) { var tag = t.replace("#","%23"); return t.link("http://search.twitter.com/search?q="+tag); } );
    return tweet_text;
  },
  
  convertToDateTime : function(string) {
    date =  new Date(string);//.toRelativeTime(5000);
    return date;
  }
  
};




jQuery(function($) {
  function debug(str){ $("#debug").append("<p>" +  str); };
  function greet(str){ $("#greet").append("<p>" +  str); };

  ws = new WebSocket("ws://localhost:9393/");
  ws.onmessage  = function(evt) { $("#msg").prepend(TwitterParsing.covertToHtml(evt.data)); };
  ws.onclose    = function() { greet("The Event Alert live streaming has been shutdown."); };
  ws.onopen     = function() {
    greet("<p>Connecting to Event Alert live streaming.<p>");
  };
});