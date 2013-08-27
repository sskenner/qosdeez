class CategoriesController < ApplicationController

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