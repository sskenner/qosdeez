class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :update, :vote]
  before_action :require_user, only: [:new, :create, :edit, :update, :vote]
  before_action :require_creator, only: [:edit, :update]

  def index
    @posts = Post.all
    categories
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user


    if @post.save
      flash[:notice] = "You created a new post!"
      redirect_to posts_path
    else
      #handle validations
      render :new
    end
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def show
    @comment = Comment.new
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "You've updated the post!"
      redirect_to posts_path
    else
      render :edit
    end
  end

  def vote
    if logged_in?
      @post.votes.each do |vote|
        if vote.creator == current_user
          flash[:error] = 'You already voted!'
          redirect_to posts_path
          return
        end
      end
      Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
      flash[:notice] = "Your vote was counted."
      redirect_to posts_path
    else
      access_denied
    end
  end

  private

  def post_params
    params.require(:post).permit(:url, :title, :description)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def require_creator
    access_denied unless @post.creator == current_user
  end
end