class BookCommentsController < ApplicationController


  def create
    @book = Book.find(params[:book_id])
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
  end

  def destroy
  #   @book = Book.find(params[:book_id])
  # 	@book_comment = @book.book_comments.find(params[:id])
 	# 	@book_comment.destroy
    
    @book = Book.find(params[:book_id])
    # @book_comment = BookComment.find(params[:book_id])
    # @bookの内容を勝手に補完してくれている
    BookComment.find_by(id: params[:id]).destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment, :book_id, :user_id)
  end

end
