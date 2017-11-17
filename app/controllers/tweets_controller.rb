class TweetsController < ApplicationController
  
  
  def top
      @tweeting = Tweet.new
  end

  def info
   @tweeting = Tweet.new
  end
  
  
  def t_user
    @tweeting = Tweet.new
    #Gemのtwitterを使うよの記述？
    require 'twitter'
    
    #twitterAPI使うための認証。secrets.ymlに記述すべきだけどできない
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = "hXhSpI3iRxzWh6XIB0osPhLT4"
      config.consumer_secret = "weuWl4LyFVuf10sWoLCRTJZynsYH2p7QTwEZ9sDohEcNyldvoT"
      config.access_token = "838731011865235456-na2d2yEiPUnRFfU6f3jo9QEr0maMWD0"
      config.access_token_secret = "9rr3sxGGs2dS8C1jV8XDPGiaXv45ywOv11I8Q9h0IAfmQ"
    end
    
    #下記コードで自分のタイムラインに関するフォロワー情報などを@tweetsに格納する
    #(include_entities: true)によってTweet内の画像URLも取得することができる。無くても稼働自体はする。
    #タイムライン自体はt_user.html.erbに記載
        
        # https://twitter.com/nanaonanaon/status/930346259176554496 のエンゲージメントを測定したい
      
      @mytwitter_id = "@sakamobi "
      @timelines = client.user_timeline("#{@mytwitter_id}")
      	
      

        #@post = Post.find_by(id: params[:id])
        @share_url = "https://sakamobi.com/news/nengajyo-noruma"
    
        @timelines.each do |tweet|
	        if tweet.urls?
	          
             @mytweet_id = tweet.id
             @mytweet_name = tweet.user.name
             @mytweet_screen_name = tweet.user.screen_name
             
             
            
             
	      	#予め@url_stringsを定義しておくためにnilを入れておく。

    	tweet.urls.each do |url|
        

      if url.expanded_url.to_s == @share_url
        
            @tweeting = Tweet.new(
            tweet_id: tweet.id,  
            twitter_name: tweet.user.name,
            twitter_screen_name: tweet.user.screen_name,
            share_retcount: tweet.retweet_count)
          
            @tweeting.save
             flash[:notice] = "セーブしました"
      end
    end
	    	end
	    end
    end
end
