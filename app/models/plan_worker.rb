class PlanWorker
  include Sidekiq::Worker

  def perform(id)
    plan = Plan.find(id)

    activity_cluster = ActivityCluster.new(plan.activities)
    best_route = activity_cluster.best_cluster_and_route

    best_route.destinations.each_with_index do |activity, index|
      activity.activity_plans.where(:plan_id => plan.id).first.
               update_attributes(:sequence => index + 1) if activity
    end
  end

end
