class GoalsController < ApplicationController
  before_action :require_signed_in
  before_action :authorized, only: [:edit, :update, :destroy]
  
  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    
    if @goal.save
      redirect_to user_url(@goal.user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end
  
  def edit
  end
  
  def update    
    if @goal.update(goal_params)
      redirect_to user_url(@goal.user_id)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @goal.destroy
    redirect_to user_url(@goal.user_id)
  end
    
  private
  
  def goal_params
    params.require(:goal).permit(:goal, :secret, :completed)
  end
  
  def authorized
    @goal = current_user.goals.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:errors] = ["You are not authorized"]
    redirect :back
  end
end
