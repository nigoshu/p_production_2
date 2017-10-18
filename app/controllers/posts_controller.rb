class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end
  
  def new
  end
  
  def create
    @post = Post.new(content: params[:content])
    @post.save
    
    #とりあえず現状はindexへリダイレクト
    redirect_to("/posts/index")
  end
  
end
