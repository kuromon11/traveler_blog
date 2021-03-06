class PostsController < ApplicationController

  before_action :move_to_index, except: [:index, :show] 
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    # タグが選択されたら、タグの絞り込み検索を行う
    if params[:tag_id]
      @tag_list = Tag.all
      @tag = Tag.find(params[:tag_id])
      # 投稿記事を新着順に並べ替え
      @posts = @tag.posts.includes(:user).order("created_at DESC").page(params[:page]).per(5)
    #一覧表示(条件なし)
    else
      # 投稿記事を新着順に並べ替え
      @tag_list = Tag.all
      @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(5)
      #いいねランキング
      @all_ranks = Post.includes(:user).order("likes_count DESC").page(params[:page]).per(10)
    end
  end

  def new
    @post = Post.new
    @post.images.new
  end

  def create
    @post = Post.new(post_params)
    # タグ関係のformat
    tag_list = params[:post][:name].split(",")
    respond_to do |format|
      if @post.save
        @post.save_posts(tag_list)
        format.html { redirect_to root_path}
        # format.json { render :show, status: :created, location: @post }
      else
        # @post = Post.new(post_params)
        # render 'new'
        format.html { render :new }
        # format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @tag_list = Tag.all
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
    # prefecture_id = Prefecture.find(params[:prefecture_id])
    if params[:prefecture_id].present?
      @posts = Post.where('prefecture_id LIKE ?', "%#{params[:prefecture_id]}%").includes(:user).order("created_at DESC").page(params[:page]).per(5)
    end
  end

  # rankingアクションを追加
  def ranking
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(5)
    @all_ranks = Post.includes(:user).order("likes_count DESC").page(params[:page]).per(10)
  end

  def edit
    @tag_list = @post.tags.pluck(:name).join(",")
  end

  def update
    # タグ関係のformat
    tag_list = params[:post][:name].split(",")
    respond_to do |format|
      if @post.update(post_params)
        @post.save_posts(tag_list)
        format.html { redirect_to @post}
        # format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        # format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:prefecture_id, :title, :content, images_attributes: [:id, :_destroy, :src], tag_ids: [:id, :name]).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to root_path, action: :index unless user_signed_in?
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
