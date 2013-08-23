class CommentsController < ApplicationController
  before_action :require_user, only: [:create, :vote]

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.creator = current_user


    if @comment.save
      flash[:notice] = "Your comment was added."
      redirect_to post_path(@post)
    else
      render "posts/show"
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
    flash[:notice] = "Your vote was counted."
    redirect_to post_path
  end
end