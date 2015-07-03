class CommentsController < ApplicationController

	before_action :authenticate_user!

	def create
		@post 					= Post.find params[:post_id]
		comment_params 	= params.require(:comment).permit(:body)
		@comment 				= Comment.new(comment_params)
		@comment.post 	= @post
		@comment.user 	= current_user
		respond_to do |format|
			if @comment.save
				CommentsMailer.delay.notify_post_owner(@comment)
				format.html { redirect_to post_path(@post), notice: 	"Comment created!" }
				format.js { render }
			else
				format.html { render "/posts/show" }
				format.js { render :create_failure }
			end
		end
	end

	def destroy
		@post = Post.find params[:post_id]
		@comment = Comment.find params[:id]
		@comment.destroy
		respond_to do |format|
			format.html { redirect_to post_path(@post), notice: "Comment deleted." }
			format.js { render }
		end
	end

end
