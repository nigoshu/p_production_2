class PostsController < ApplicationController
    before_action :authenticate_user
    before_action :ensure_correct_user, {only:[ :destroy]}


  
  def index
    @posts = Post.all.order(created_at: :desc)
  end
  
  
  def new
  end
  
  
  def create
    @post = Post.new(
      content: params[:content],
      title: params[:title],
      user_id: @current_user.id )
    
    if @post.save
      
       #とりあえず現状はindexへリダイレクト
      redirect_to("/posts/index")      
    else
      render("posts/new")
    end
  end
  
  
  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
    @likes_count = Like.where(post_id: @post.id).count
  end
  
  def edit
  @post = Post.find_by(id: params[:id])
  end
  
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.title = params[:title]
    @post.content = params[:content]
    if @post.save
    flash[:notice] = "投稿を編集しました"
           #とりあえず現状はindexへリダイレクト
    redirect_to("/posts/  def ensure_correct_userindex")  
    else
      render("posts/edit")
    end
    
  end
  
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    
    #とりあえず現状はindexへリダイレクト
    redirect_to("/posts/index")
  end
  
  def ensure_correct_user
    @user = User.find_by(id: params[:id])
    if @user.id = @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  
  #シェア完了機能模索中
  
  def share
    require 'twitter'
    
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = "hXhSpI3iRxzWh6XIB0osPhLT4"
      config.consumer_secret = "weuWl4LyFVuf10sWoLCRTJZynsYH2p7QTwEZ9sDohEcNyldvoT"
      config.access_token = "838731011865235456-na2d2yEiPUnRFfU6f3jo9QEr0maMWD0"
      config.access_token_secret = "9rr3sxGGs2dS8C1jV8XDPGiaXv45ywOv11I8Q9h0IAfmQ"
    end
    
    #データベースを作ったらparamsで引っ張ってくる。
    @timeline = client.user_timeline(@current_user.name)
    
    @post = Post.find_by(id: params[:id])
    @share_url = "https://ta215-production2.herokuapp.com/"
    
    #シェア判定機能
    
    @timeline.each do |tweet|
      if tweet.urls?
        
        tweet.urls.each do |url| 
          if url.expanded_url.to_s == @share_url 
            
            if @post.content_charge > 0
              
              @user = User.find_by(id: session[:user_id])
              @user.user_charge = @user.user_charge + 100
              @post.content_charge = @post.content_charge - 100
            
              flash[:notice] = "100円ゲットん！！"
              @post.save
              @user.save
            break
            
            else
            flash[:notice] = "チャージが無くなりました!!"
            end
            
          else
            flash[:notice] = "シェアされてないよ！！"
          end
        end
      end 
    end 
    
  end
  
end
