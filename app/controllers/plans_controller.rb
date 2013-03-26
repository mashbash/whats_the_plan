class PlansController < ApplicationController

  def index
    @plans = Plan.all
  end

  def new
    @plan = Plan.new
    @plan.activities.build
  end

  def create
    @plan = Plan.new(params[:plan])
    @plan.user = current_user if current_user

    if @plan.save
      render :json => { plan: @plan }
    else
      render :json => { plan: @plan, activities: @plan.activities }
    end
  end

  def show
    @plan = Plan.find(params[:id])
    @show_plans = Plan.where('title != ?', @plan.title)
  end
end


