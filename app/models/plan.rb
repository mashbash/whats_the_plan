class Plan < ActiveRecord::Base

  attr_accessible :user_id, :start_date, :end_date, :title

  validates :user_id, :title, :end_date, :start_date, :presence => true
  validate :end_date_before_start_date

  private

  def end_date_before_start_date
    
    puts self.end_date
    puts self.start_date
    if self.end_date < self.start_date
      errors[:base] << "End date cannot be earlier than start date" #validations should return true or false
    end
  end    
end
