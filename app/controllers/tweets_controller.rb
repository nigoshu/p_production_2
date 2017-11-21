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
      config.consumer_key = Rails.application.secrets.user_consumer_key
      config.consumer_secret = Rails.application.secrets.user_consumer_secret
      config.access_token = Rails.application.secrets.user_access_token
      config.access_token_secret = Rails.application.secrets.user_access_token_secret
    end
    
    #下記コードで自分のタイムラインに関するフォロワー情報などを@tweetsに格納する
    #(include_entities: true)によってTweet内の画像URLも取得することができる。無くても稼働自体はする。
    #タイムライン自体はt_user.html.erbに記載
        
        # https://twitter.com/nanaonanaon/status/930346259176554496 のエンゲージメントを測定したい
      
      @mytwitter_id = "@sakamobi "
      @timelines = client.user_timeline("#{@mytwitter_id}",count: 200) #レートリミット200。カウント数を上げないと過去分を持ってこられない。
      	
      

        #@post = Post.find_by(id: params[:id])
        @share_url = "https://sakamobi.com/news/pteronura-brasiliensis"
    
        @timelines.each do |tweet|
	        if tweet.urls?
	          
             @mytweet_id = tweet.id
             @mytweet_name = tweet.user.name
             @mytweet_screen_name = tweet.user.screen_name

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
