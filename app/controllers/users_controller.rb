class UsersController < ApplicationController
  
  #現在showアクションはTOPページのリンクからジャンプするとユーザーIDを拾えないのでエラーになります。

  def index
   @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
      )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("/new")
    end
  end
  
  def edit 
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end
  
  def login_form
  end
  
  def login
    @user = User.find_by(email: params[:email],
                          password: params[:password])
    if @user
    session[:user_id] = @user.id
    flash[:notice] = "ログインに成功しました"
    redirect_to("/users/index")
    else
      @error_message = "ログインに失敗しました"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
  
  
  #削除機能はいずれパスワードを入力してポップアップウィンドウでアテンションする。
  #とりあえず今は作業様で削除ボタン設置
  
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:notice] = "ユーザーアカウントを削除しました"
    redirect_to("/")
  end
  
  
end
