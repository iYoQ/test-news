class NewsPostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :admin?, only: [:edit, :update, :destroy]

  def index
    @news_posts = NewsPost.all
  end

  def new
    @news_post = NewsPost.new
  end

  def create
    @news_post = NewsPost.new(news_post_params)
    @news_post.user_id = current_user.id
    if @news_post.save
      redirect_to @news_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @news_post.with_lock do
      if @news_post.edit_count_left < 1
        redirect_to @news_post, alert: 'Максимум 5 редакций'
      elsif @news_post.update(news_post_params)
        redirect_to @news_post, notice: 'Обновленно'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @news_post.destroy
    redirect_to root_path
  end

  def show
  end

  def edit
  end

  private

  def news_post_params
    params.require(:news_post).permit(:title, :body)
  end

  def find_post
    @news_post = NewsPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def admin?
    if !current_user.admin?
      redirect_to root_path
    end
  end
end
