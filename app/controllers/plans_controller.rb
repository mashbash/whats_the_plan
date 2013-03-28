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
    if @plan && @plan.sequenced
      @nearby_plans = Plan.nearby_plans(@plan)
    else
      render 'processing'
    end
  end

  def refresh
    @plan = Plan.find(params[:id])
    if @plan && @plan.sequenced
      render :json => { :sequenced => true }
    else
      render :json => { :sequenced => false }
    end
  end
end


