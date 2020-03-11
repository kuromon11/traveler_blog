class LikesController < ApplicationController

  def create
    @like = Like.create(user_id: current_user.id, post_id: params[:post_id])
    @like.save
    @posts = Post.all
    redirect_to ("/posts/#{params[:post_id]}")
    # format形式で分岐（非同期化）
    # if @like.save
    #   respond_to do |format|
    #     format.html {redirect_to ("/posts/#{params[:post_id]}") }
    #     format.json
    #   end
    # end
  end

  def destroy
    @post = Post.find(params[:id])
    @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    @like.destroy
    @posts = Post.all
    redirect_to ("/posts/#{params[:post_id]}")
    # format形式で分岐（非同期化）
    # if @like.destroy
    #   respond_to do |format|
    #     format.html {redirect_to ("/posts/#{params[:post_id]}") }
    #     format.json
    #   end
    # end
  end


  private
  def post_params
    params.require(:post).permit(:user_id, :post_id).merge(user_id: current_user.id)
  end

end
