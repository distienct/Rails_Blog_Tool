class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find params[:post_id]
    favourite          = current_user.favourites.new
    favourite.post = post
    if favourite.save
      redirect_to post, notice: "Question favourited"
    else
      redirect_to post, alert: "Can't favourite"
    end
  end

  def destroy
		post = Post.find params[:post_id]
		favourite = current_user.favourites.find params[:id]
    favourite.destroy
    redirect_to post, notice: "Un-Favourited"
  end

end
