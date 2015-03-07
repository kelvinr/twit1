class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(params.require(:user).permit(:username, :email, :password))

    if @user.save
      flash[:success] = "Your account has been created."
      redirect_to user_path(@user.username)
    else
      render :new
    end
  end

  def show
    @user = User.find_by username: params[:username]
  end
end