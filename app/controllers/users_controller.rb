class UsersController < ApplicationController
  before_action :require_user, only: [:follow, :unfollow, :timeline, :mentions]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(params.require(:user).permit(:username, :email, :password))

    if @user.save
      flash[:success] = "Your account has been created."
      session[:user_id] = @user.id
      redirect_to user_path(@user.username)
    else
      render :new
    end
  end

  def show
    @user = User.find_by username: params[:username]
  end

  def follow
    user = User.find(params[:id])
    if user and current_user != user
      current_user.following << user
      redirect_to user_path(user.username)
      flash[:success] = "You are now following #{user.username}."
    else
      wrong_path
    end
  end

  def unfollow
    user = User.find(params[:id])
    rel = Relationship.where(follower_id: current_user.id, leader_id: user.id).first
    if user && rel
      rel.destroy
      redirect_to user_path(user.username)
      flash[:success] = "You've unfollowed #{user.username}."
    else
      wrong_path
    end
  end

  def timeline
    @statuses = []
    current_user.following.each do |user|
      @statuses << user.statuses
    end
    @statuses.flatten!
  end

  def mentions
    current_user.mark_unread_mentions!
  end
end
