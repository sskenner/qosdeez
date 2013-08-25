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
    if logged_in?
      @comment = Comment.find(params[:id])
      @comment.votes.each do |vote|
        if vote.creator == current_user
          flash[:error] = "You already voted!"
          redirect_to post_path(@comment.post)
          return
        end
      end
      Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
          flash[:notice] = "Your vote was counted."
          redirect_to post_path(@comment.post)
    else
      access_denied
    end
  end
end