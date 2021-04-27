class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @books = Book.all
  end
  
  def index
    @users = User.all
    @books = Book.all
    @book = Book.new
    @user = current_user
  end
  
  private
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
