class Activity < ActiveRecord::Base

  attr_accessible :title, :street, :city, :state, :zip_code, :country,
                  :longitude, :latitude, :meal

  validates :title,     :presence => true
  validates :street,    :presence => true
  validates :meal,      :presence => true

  has_many :activity_plans
  has_many :plans, :through => :activity_plans

  before_create :geocode

  private
  def geocode
    api_details = Geocoder.search(address_string).first 
    raise InvalidAddressError if api_details.nil?

    self.latitude  = api_details.data["geometry"]["location"]["lat"]
    self.longitude = api_details.data["geometry"]["location"]["lng"]
  end

  def address_string
    "#{street}, #{city}, #{state} #{zip_code} #{country}"
  end
end
