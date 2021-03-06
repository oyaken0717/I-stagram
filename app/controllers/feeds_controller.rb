class FeedsController < ApplicationController
  before_action :check_logged_in, only:[:new]
  before_action :set_feed, only:[:show,:edit,:update,:destroy]
  before_action :check_correct_user, only:[:edit, :update, :destroy]

  def index
    @feeds = Feed.all
  end

  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  def create
    @feed = Feed.new(feed_params)
    @feed.user = current_user
    if @feed.save
      ContactMailer.contact_mail(@feed).deliver
      redirect_to feeds_path, notice:"投稿完了"
    else
      render "new"
    end
  end

  def confirm
    @feed = current_user.feeds.build(feed_params)
    render :new if @feed.invalid?
  end

  def show
    @favorite = current_user.favorites.find_by(feed_id: @feed.id)
  end

  def edit
  end

  def update
    if @feed.update(feed_params)
      redirect_to feeds_path, notice: "編集完了"
    else
      render "edit"
    end
  end

  def destroy
    @feed.destroy
    redirect_to feeds_path, notice:"削除完了"
  end

  private

  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:image, :image_cache, :content)
  end

  def check_correct_user
    if current_user != @feed.user
      redirect_to new_session_path
    end
  end

  def check_logged_in
    redirect_to new_session_path unless logged_in?
  end
end
