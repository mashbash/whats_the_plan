class Plan < ActiveRecord::Base

  attr_accessible :start_date, :end_date, :title, :activities_attributes

  validates :user, :presence => true
  validates :title, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true

  validate :end_date_before_start_date

  belongs_to :user 
  has_many :activity_plans
  has_many :activities, :through => :activity_plans, :inverse_of => :plans
  accepts_nested_attributes_for :activities
  attr_accessible :activities_attributes

  after_create :create_sequence

  def best_route
    route = Activity.joins(:activity_plans).
                     where(:id => activity_plans.chosen.pluck(:activity_id)).
                     order(:sequence).all
                     
    route.length == ActivityCluster::MAX_ROUTE_LENGTH ? route : pad(route)
  end

  def sorted_activities_plans
    self.activity_plans.order(:sequence)
  end

  private
  def create_sequence
    activity_cluster = ActivityCluster.new(self.activities)
    best_route = activity_cluster.best_cluster_and_route

    best_route.destinations.each_with_index do |activity, index|
      activity.activity_plans.where(:plan_id => self.id).first.
               update_attributes(:sequence => index + 1) if activity
    end
  end

  def end_date_before_start_date
    if self.end_date && self.start_date && self.end_date < self.start_date
      errors.add(:start_date, "End date cannot be earlier than start date")
    end
  end

  def activity_sequence(activity)
    self.activity_plans.where(:activity_id => activity.id).first.sequence
  end

  def pad(activities)
    (1..ActivityCluster::MAX_ROUTE_LENGTH).map do |n|
      activities.find { |activity| activity_sequence(activity) == n }
    end
  end
end
