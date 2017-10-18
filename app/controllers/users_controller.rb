class UsersController < ApplicationController
  
  #現在showアクションはTOPページのリンクからジャンプするとユーザーIDを拾えないのでエラーになります。
  def show
    @user = User.find_by(id: params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email]
      )
    if @user.save
      flash[:notice] = "登録が完了しました"
    redirect_to("users/#{@user.id}")
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
    @user.emal = params[:email]
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end
  
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:notice] = "ユーザーアカウントを削除しました"
    redirect_to("/home")
  end
  
  
end
