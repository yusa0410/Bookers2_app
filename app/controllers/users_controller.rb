class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, {only: [:edit,:update,:destroy]}
 

  def show
    @user = User.find(params[:id])
    @books = Book.all
    @book = Book.new
    @relationship = @user.followings.find_by(follower_id: current_user.id)  #追加フォロー機能
  end

  def index
    @users = User.all
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to "/users/#{current_user.id}"
    else
      flash[:notice] = "errors prohibited this obj from being saved."
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  # ==============追加フォロー================

  def follows
    @user = User.find(params[:id])
    @followings = @user.following_users
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.follower_users
  end

  # ==============追加フォロー================

  private
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def  ensure_current_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  

end
