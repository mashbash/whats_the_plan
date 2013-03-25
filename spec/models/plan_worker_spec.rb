require 'spec_helper'

describe PlanWorker do
  let(:plan) { create(:plan_with_activities)}
  let(:plan_worker) { PlanWorker.new }

  it 'should update the best route' do
    plan.best_route.should eq [nil, nil, nil, nil]
    plan_worker.perform(plan.id)
    p plan.best_route
  end

end
