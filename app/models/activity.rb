class Activity < ActiveRecord::Base

  attr_accessible :title, :street, :city, :state, :zip_code, :country,
                  :longitude, :latitude, :meal, :image_url

  validates :title,     :presence => true
  validates :meal,      :presence => true
  validates :latitude,  :presence => true
  validates :longitude, :presence => true

  has_many :activity_plans
  has_many :plans, :through => :activity_plans, :inverse_of => :activities


  before_save :scrub_attributes
  geocoded_by :full_address

  def gmaps_string
    "#{street}, #{city}, #{state}"
  end

  private
  def full_address
    "#{title}, #{street}"
  end

  def scrub_attributes
    self.attributes.each do |attr_value|
      if attr_value[1].class == String
        attr_value[1].gsub!(/undefined/,"")
        attr_value[1].strip!
      end
    end
  end
end
