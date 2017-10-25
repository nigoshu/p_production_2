class PostsController < ApplicationController
    before_action :authenticate_user
    before_action :ensure_correct_user, {only:[:edit, :update, :destroy]}


  
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
  
  def ensure_correct_user
    @user = User.find_by(id: params[:id])
    if @user.id = @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  
  #拡散機能を模索中
  def diffusion
  end
  
end
