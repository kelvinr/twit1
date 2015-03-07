class StatusesController < ApplicationController

  def new
    @status = Status.new
  end


  def create
    @status = Status.new(params.require(:status).permit(:body))
    @user = User.first
    @status.creator = @user

    if @status.save
      flash[:success] = "Your status has been created"
      redirect_to user_path(@user.username)
    else
      render :new
    end
  end
end