class UsersController < ApplicationController

  def index
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order

  end


  def edit
    @user_image = User.new
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def create

  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
