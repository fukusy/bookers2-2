class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    # ここにifでbook_pathかbooks_pathか判断する
    redirect_to book_path(book)
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    # ここにifでbook_pathかbooks_pathか判断する
    redirect_to book_path(book)
  end

end
