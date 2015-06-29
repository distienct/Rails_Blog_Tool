class VotesController < ApplicationController

  before_action :authenticate_user!

  def create
    post = Post.find params[:post_id]

    vote = current_user.votes.new(vote_params)
    vote.post = post
    if vote.save
      redirect_to post, notice: "Voted!"
    else
      redirect_to post, alert: "Couldn't vote"
    end
  end

  def destroy
    post = Post.find params[:post_id]

    vote = current_user.votes.find params[:id]
    vote.destroy
    redirect_to post, notice: "Vote Removed"
  end

  def update
    post = Post.find params[:post_id]

    vote = current_user.votes.find params[:id]
    if vote.update(vote_params)
      redirect_to post, notice: "Vote Changed!"
    else
      redirect_to post, alert: "Vote Un-Changed"
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:is_up)
  end

end
