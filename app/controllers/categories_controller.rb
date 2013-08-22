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
      render '/posts'
    end
  end

  def show
  end
end