class CollaborationsController < ApplicationController

    before_action :authenticate_user!
    before_action :find_post

    def create
      @collaboration = Collaboration.new
      @collaboration.user = current_user
      @collaboration.post = @post
      if @collaboration.save
        redirect_to post_path(@post), notice: "Joined"
      else
        redirect_to post_path(@post), alert: "Can't Join"
      end
    end

    private
    def find_post
      @post = Post.find params[:post_id]
    end

end
