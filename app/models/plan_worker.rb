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

    best_ids = best_route.destinations.map { |activity| activity.id if activity }
    city     = Activity.find(best_ids.compact).first.city

    plan.update_attributes(:sequenced => 1, :city => city, :best_route_ids => best_ids)
  end

end
