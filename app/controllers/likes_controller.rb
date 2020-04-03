class LikesController < ApplicationController

  def create
    @like = Like.create(user_id: current_user.id, post_id: params[:post_id])
    @like.save
    @posts = Post.all
    @likes = Like.where(post_id: params[:post_id])
    redirect_to "/posts/#{params[:post_id]}"
  end

  def destroy
    @post = Post.find(params[:id])
    @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    @like.destroy
    @posts = Post.all
    @likes = Like.where(post_id: params[:post_id])
    redirect_to "/posts/#{params[:post_id]}"
  end

  private
  def post_params
    params.require(:post).permit(:user_id, :post_id).merge(user_id: current_user.id)
  end

end
