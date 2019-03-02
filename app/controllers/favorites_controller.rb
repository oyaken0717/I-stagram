class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(feed_id: params[:feed_id])
    redirect_to feeds_url, notice: "#{favorite.feed.user.name}さんの投稿をお気に入りしました"
  end

  def index
    @favorites = Favorite.all
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to feeds_url, notice: "#{favorite.feed.user.name}さんの投稿を解除しました"
　end
end

end
