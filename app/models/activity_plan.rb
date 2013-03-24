class ActivityPlan < ActiveRecord::Base
  attr_accessible :plan_id, :activity_id, :sequence

  belongs_to :activity
  belongs_to :plan

  scope :chosen, where("sequence IS NOT NULL")

end
