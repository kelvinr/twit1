class StatusesController < ApplicationController
  before_action :require_user

  def new
    @status = Status.new
  end

  def create
    @status = Status.new(params.require(:status).permit(:body))
    @user = current_user
    @status.creator = @user

    if @status.save
      flash[:success] = "Your status has been created"
      redirect_to user_path(@user.username)
    else
      render :new
    end
  end

  def retweet
    status = Status.find(params[:id])
    new_status = Status.create(body: status.body, creator: current_user, parent_status: status)

    new_status.save ? flash[:success] = 'Retweeted!' : flash[:error] = 'Couldn\'t retweet!'
    redirect_to :back
  end
end
