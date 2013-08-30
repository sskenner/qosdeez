class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :update, :vote]
  before_action :require_user, only: [:new, :create, :edit, :update, :vote]
  before_action :require_creator_or_admin, only: [:edit, :update]

  def index
    @posts = Post.all

    respond_to do |format|

      format.html do
      end

      format.js do
        render :index
      end

    end
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user


    if @post.save
      params[:post][:categories].each do |category_id|
        if category_id != ""
          Label.create(:category_id => category_id, :post_id => @post.id)
        end
      end
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
    categories = []

    if @post.update(post_params)
      params[:post][:categories].each do |category_id|
        if category_id != ""
          if
            categories << category_id
          end
        end
      end
      @post.categories.delete_all
      categories.each do |category|
        Label.create(:category_id => category, :post_id => @post.id)
      end
      flash[:notice] = "You've updated the post!"
      redirect_to posts_path
    else
      render :edit
    end
  end

  def vote

    @post.votes.each do |vote|
      if vote.creator == current_user
        @voted = true

        respond_to do |format|

          format.html do
            flash[:error] = 'You already voted!'
            redirect_to posts_path
          end

          format.js do
            render :vote
          end

          return
        end
      end
    end

    Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|

      format.html do
        flash[:notice] = "Your vote was counted."
        redirect_to posts_path
      end

      format.js

    end
  end

  private

  def post_params
    params.require(:post).permit(:url, :title, :description)
  end

  def set_post
    @post = Post.find_by(slug: params[:id])
  end

  def require_creator_or_admin
    access_denied unless logged_in? && (@post.creator == current_user || current_user.admin?)
  end
end
