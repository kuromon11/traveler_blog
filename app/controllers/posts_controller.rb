class PostsController < ApplicationController

  before_action :move_to_index, except: [:index, :show] 

  def index
    # 投稿記事を新着順に並べ替え
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(5)
    @all_ranks = Post.includes(:user).order("likes_count DESC").page(params[:page]).per(10)
  end

  def new
    @post = Post.new
    @tag = Tag.new
  end

  def create
    # tag_list = params[:post][:name].split(",")
    Post.create(post_params)
    redirect_to root_path
  end

  def show
    @post = Post.find(params[:id])
    # @tag = Tag.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order("created_at DESC")
    @likes_count = Like.all.count
    @likes_count = Like.where(post_id: @post.id).count
  end

  # searchアクションを作成
  def search
    @posts = Post.search(params[:keyword]).includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end
  # rankingアクションを追加
  def ranking
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(5)
    @all_ranks = Post.includes(:user).order("likes_count DESC").page(params[:page]).per(10)
  end

  def edit
    @post = Post.find(params[:id])
    # @tag = Tag.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    # tag = Tag.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :image, tag_ids: []).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to root_path, action: :index unless user_signed_in?
  end

end
