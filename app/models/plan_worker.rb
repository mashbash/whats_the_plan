class PlanWorker
  include Sidekiq::Worker

  def perform(id)
    plan = Plan.includes(:activities).find(id)

    plan.activities.each { |activity| activity.save }

    activity_cluster = ActivityCluster.new(plan.activities)
    best_route = activity_cluster.best_cluster_and_route

    best_route.destinations.each_with_index do |activity, index|
      activity.activity_plans.where(:plan_id => plan.id).first.
               update_attributes(:sequence => index + 1) if activity
    end

    plan.update_attributes(:sequenced => 1, :city => plan.best_route.first.city)
  end

end
