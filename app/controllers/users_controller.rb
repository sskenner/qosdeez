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
    @user = current_user
  end

  def update
    @user = User.find_by(slug: params[:id])
    if @user.update(users_params)
      flash[:notice] = 'You have updated your profile.'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def show
    @user = User.find_by(slug: params[:id])
  end

  private
  def users_params
    params.require(:user).permit(:username, :password, :time_zone, :email)
  end
end