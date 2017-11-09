class HomeController < ApplicationController
    
  def top
      @tweet = Home.new
  end

  def info
   @tweet = Home.new
  end
  
  
  def t_user
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
        @tweets = client.home_timeline(include_entities: true)
        
        
  end
end
