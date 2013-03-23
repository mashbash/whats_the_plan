class PlansController < ApplicationController

  def index
  
    @plans = Plan.all
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(params[:plan])
    @plan.user = current_user

    if @plan.save
      render plan_path(@plan)
      # redirect_to root_path
    else
      @plan.errors.full_messages
      render new_plan_path
    end
  end

  def show
    @plan = Plan.find(params[:id])
    @activities_plans = @plan.sorted_activities_plans
  end


end


