class Activity < ActiveRecord::Base

  attr_accessible :title, :street, :city, :state, :zip_code, :country,
                  :longitude, :latitude, :meal, :image_url

  validates :title,     :presence => true
  validates :meal,      :presence => true

  has_many :activity_plans
  has_many :plans, :through => :activity_plans, :inverse_of => :activities

  before_save :scrub_attributes
  before_create :check_lat_long_present
  geocoded_by :full_address

  def gmaps_string
    "#{street}, #{city}, #{state}"
  end

  private
  def check_lat_long_present
    fetch_api_details unless self.latitude && self.longitude
  end

  def fetch_api_details
    @api_details = Geocoder.search(full_address).first
    raise Exceptions::InvalidAddressError if @api_details.nil?
    scrub_address_street
    scrub_address_other
    set_coordinates
  end

  def scrub_address_street
    name, number = ""
    @api_details.data["address_components"].each do |c|
      number = c["long_name"] if c["types"].include? "street_number"
      name   = c["long_name"] if c["types"].include? "route"
    end
    self.street = "#{number} #{name}" unless name.length.zero?
  end

  def scrub_address_other
    @api_details.data["address_components"].each do |c|
      self.city     = c["long_name"]  if c["types"].include? "locality"
      self.zip_code = c["long_name"]  if c["types"].include? "postal_code"
      self.state    = c["short_name"] if c["types"].include? "administrative_area_level_1"
      self.country  = c["long_name"]  if c["types"].include? "country"
    end
  end

  def set_coordinates
    self.latitude  = @api_details.data["geometry"]["location"]["lat"]
    self.longitude = @api_details.data["geometry"]["location"]["lng"]
  end

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
