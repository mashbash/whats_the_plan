class ActivityPlan < ActiveRecord::Base
  attr_accessible :plan_id, :activity_id, :sequence

  # validates :sequence, :presence => true

  belongs_to :activity
  belongs_to :plan
end
