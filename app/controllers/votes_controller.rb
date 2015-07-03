class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find params[:post_id]
    @vote = current_user.votes.new(vote_params)
    @vote.post = @post
    respond_to do |format|
      if @vote.save
        format.html { redirect_to @post, notice: "Voted!" }
        format.js { render }
      else
        format.html { redirect_to @post, alert: "Couldnt Vote!" }
        format.js { render }
      end
    end
  end

  def update
    @post = Post.find params[:post_id]
    @vote = current_user.votes.find params[:id]
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to @post, notice: "Vote updated!" }
        format.js { render }
      else
        format.html { redirect_to @post, alert: "Vote couldn't update" }
        format.js { render }
      end
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    @vote     = current_user.votes.find params[:id]
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to @post, notice: "Vote removed" }
      format.js   { render }
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:is_up)
  end

end
