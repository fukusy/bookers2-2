class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = search_for(@model, @content, @method)
  end

  private
  def search_for(model, content, method)
    if model == 'user'
      if method == 'perfect'  # 完全一致検索
        User.where(name: content)
      elsif method == 'front_match'   # 前方一致検索
        User.where('name LIKE ?', content+'%')
      elsif method == 'back_match'   # 後方一致検索
        User.where('name LIKE ?', '%'+content)
      else    # 部分一致検索
        User.where('name LIKE ?', '%'+content+'%')
      end
    elsif model == 'book'
      if method == 'perfect'
        Book.where(title: content)
      elsif method == 'front_match'   # 前方一致検索
        Book.where('name LIKE ?', content+'%')
      elsif method == 'back_match'   # 後方一致検索
        Book.where('name LIKE ?', '%'+content)
      else
        Book.where('title LIKE ?', '%'+content+'%')
      end
    end
  end
  
end
