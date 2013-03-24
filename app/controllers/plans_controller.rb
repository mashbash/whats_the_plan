class PlansController < ApplicationController

  def index
    @plans = Plan.all
  end

  def new
    @plan = Plan.new
    @plan.activities.build
  end

  def create
    debugger
    @plan = Plan.new(params[:plan])
    @plan.user = current_user if current_user

    if @plan.save
      redirect_to plan_path(@plan)
    else
      render new_plan_path
    end
  end

  def show
    @plan = Plan.find(params[:id])
    @activities_plans = @plan.sorted_activities_plans.limit(4)
  end


end


