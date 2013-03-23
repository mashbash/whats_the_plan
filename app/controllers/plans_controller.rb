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
    else
      @plan.errors.full_messages
      render new_plan_path
    end
  end

  def show

  end


end


