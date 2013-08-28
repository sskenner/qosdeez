class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)

    if @user.save
      flash[:notice] = 'You have registered, now log in.'
      redirect_to login_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show

    @user = User.find_by(slug: params[:id])
  end

  private
  def users_params
    params.require(:user).permit(:username, :password, :time_zone, :email)
  end
end