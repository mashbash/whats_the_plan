class Plan < ActiveRecord::Base

  NEARBY_PLANS = 8

  attr_accessible :start_date, :end_date, :title, :city, :sequenced, :activities_attributes

  validates :title, :presence => true
  validate  :end_date_before_start_date

  belongs_to :user
  has_many :activity_plans
  has_many :activities, :through => :activity_plans, :inverse_of => :plans
  accepts_nested_attributes_for :activities

  before_validation :default_dates, :unless => Proc.new { self.start_date }
  after_create :create_sequence

  def self.nearby_plans(plan)
    Plan.where(:city => plan.city).where("id != ?", plan.id).last(NEARBY_PLANS)
  end

  def best_route
    route = Plan.joins(:activity_plans).where(:id => activity_plans).order(:sequence)

    route.length == ActivityCluster::MAX_ROUTE_LENGTH ? route : pad(route)
  end

  private
  def create_sequence
    PlanWorker.perform_in(3.seconds, self.id)
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

  def default_dates
    self.start_date = Date.today
    self.end_date = Date.tomorrow
  end
end
