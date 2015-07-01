class PostsController < ApplicationController

	before_action :find_post, only: [:edit, :update, :destroy, :show]
	before_action :authenticate_user!, except: [:index, :show]
	before_action :authorize, only: [:edit]
	before_action :authorize_delete, only: [:destroy]

	def index
		@posts = Post.page(params[:page]).per(8).order("id ASC")
	end

	def new
		@post = Post.new(title: "Enter a title!", body: "What's there to say?")
	end

	def create
		@post = Post.new(post_params)
		@post.user = current_user

		if @post.save
			redirect_to post_path(@post), notice: "Post Created!"
		else
			render :new
		end
	end

	def show
		@comment = Comment.new
		@like = @post.like_for(current_user)
		@vote = @post.vote_for(current_user)
		@favourite = @post.favourite_for(current_user)
		@collaboration = @post.collaborating_users
	end

	def edit
	end

	def update
		if @post.update(post_params)
			redirect_to post_path(@post), notice: "Post has been updated"
		else
			render :edit
		end
	end

	def destroy
		@post.destroy
		redirect_to posts_path, notice: "Post Deleted"
	end

private

	def post_params
		post_params = params.require(:post).permit([:title, :body, :category_id, {tag_ids: []}])
	end

	def find_post
		@post = Post.find params[:id]
	end

	def authorize
    redirect_to root_path, alert: "Access denied." unless can? :edit, @post
  end

	def authorize_delete
		redirect_to post_path(@post), alert: "Access denied" unless can? :destroy, @post
	end
end
