class PostsController < ApplicationController

  before_action :move_to_index, except: [:index, :show] 

  def index
    # @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    # 投稿記事を新着順に並べ替え
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(5)
    @all_ranks = Post.includes(:user).order("likes_count DESC").page(params[:page]).per(10)
  end

  def new
    @post = Post.new
    @post.images.new
    # @tag = Tag.find(params[:id])
  end

  def create

    @post = Post.new(post_params)
    # tag_list = params[:post][:name].split(",")
    # tag = Tag.find(params[:tag_id])
    # post.tags << tag
    if @post.save
      redirect_to root_path
    else
      @post = Post.new(post_params)
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order("created_at DESC")
    @likes_count = Like.all.count
    @likes_count = Like.where(post_id: @post.id).count
  end

  # searchアクションを作成
  def search
    @posts = Post.search(params[:keyword]).includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  # prefecturesアクションを追加
  def prefectures
    if params[:prefecture_id].present?
      @posts = Post.where('prefecture_id LIKE ?', "%#{params[:prefecture_id]}%").includes(:user).order("created_at DESC").page(params[:page]).per(5)
    end
    # 条件演算子：trueなら都道府県検索
    # @tag = Tag.find(params[:tag_id]) if params[:tag_id].present?
    # @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts.includes(:user).order("created_at DESC").page(params[:page]).per(5) : Post.all
  end

  # rankingアクションを追加
  def ranking
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(5)
    @all_ranks = Post.includes(:user).order("likes_count DESC").page(params[:page]).per(10)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params) 
      redirect_to post_path(@post.id)
    else
      render 'edit'
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:tag_ids, :prefecture_id, :title, :content, images_attributes: [:id, :_destroy, :src]).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to root_path, action: :index unless user_signed_in?
  end

end
