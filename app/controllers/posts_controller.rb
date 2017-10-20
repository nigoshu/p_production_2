class PostsController < ApplicationController
  

  
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
    redirect_to("/posts/index")  
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
  
end
