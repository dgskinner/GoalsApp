class GoalsController < ApplicationController
  before_action :require_logged_in
  before_action :require_goal_owner, only: [:edit, :update, :destroy]
  
  def new
    @goal = Goal.new
    render :new
  end
  
  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end
  
  def show
    @goal = Goal.find(params[:id])
    render :show
  end
  
  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end
  
  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_url(@goal.user)
  end
  
  private
  
  def goal_params
    params.require(:goal).permit(:title, :description, :privacy, :status)
  end
  
  def require_goal_owner
    @goal = Goal.find(params[:id])
    unless current_user == @goal.user
      redirect_to goal_url(@goal)
    end
  end
end
