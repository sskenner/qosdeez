class CategoriesController < ApplicationController
  before_action :require_admin, only: [:create, :new]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))

    if @category.save
      flash[:notice] = "You created a new category!"
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @category = Category.find_by(slug: params[:id])
  end
end