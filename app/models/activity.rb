class Activity < ActiveRecord::Base

  validates :title, :presence => true
  validates :street, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip_code, :presence => true
  validates :country, :presence => true
  validates :latitude, :presence => true
  validates :longitude, :presence => true
  validates :meal, :presence => true

  has_many :activity_plans
  has_many :plans, :through => :activity_plans

  # before_save :calculate_longitude
  # before_save :calculate_latitude

  # def calculate_longitude
  # end

  # def calculate_latitude
  # end

end
