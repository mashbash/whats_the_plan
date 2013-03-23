class Plan < ActiveRecord::Base

  attr_accessible :start_date, :end_date, :title

  validates :user_id, :presence => true
  validates :title, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true

  validate :end_date_before_start_date

  belongs_to :user 
  has_many :activity_plans
  has_many :activities, :through => :activity_plans
  accepts_nested_attributes_for :activities
  attr_accessible :activities_attributes

  private
  def end_date_before_start_date
    if self.end_date && self.start_date && self.end_date < self.start_date
      errors.add(:start_date, "End date cannot be earlier than start date") #validations should return true or false
    end
  end    
end
