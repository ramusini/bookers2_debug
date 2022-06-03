class FavoritesController < ApplicationController
  def create
    @book_favorite = Favorite.new(user_id: current_user.id, book_id: params[:book_id])
    @book_favorite.save
  end

  def destroy
    #find_byはid(主キー)か不明で、別の条件でレコードを検索したい場合
    @book_favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
    @book_favorite.destroy
  end
end
