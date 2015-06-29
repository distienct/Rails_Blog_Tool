class LikesController < ApplicationController

  def create
    @post = Post.find params[:post_id]
    @like = Like.new
    @like.user = current_user
    @like.post_id = params[:post_id]
    if @like.save
      redirect_to post_path(@post), notice: "Liked!"
    else
      redirect_to post_path(@post), alert: "Couldn't Like!"
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    @like = @post.like_for(current_user)
    if @like.destroy
      redirect_to post_path(@post), notice: "Unliked!"
    end
  end

end
