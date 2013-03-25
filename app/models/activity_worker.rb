class ActivityWorker
  include Sidekiq::Worker

  # def perform(id)
  #   @activity = Activity.find(id)
  #   fetch_api_details
  # end

  # def fetch_api_details
  #   @api_details = Geocoder.search(full_address).first
  #   raise Exceptions::InvalidAddressError if @api_details.nil?
  #   scrub_address_street
  #   scrub_address_other
  #   set_coordinates
  #   @activity.save
  # end

  # def scrub_address_street
  #   name, number = ""
  #   @api_details.data["address_components"].each do |c|
  #     number = c["long_name"] if c["types"].include? "street_number"
  #     name   = c["long_name"] if c["types"].include? "route"
  #   end
  #   @activity.street = "#{number} #{name}"
  # end

  # def scrub_address_other
  #   @api_details.data["address_components"].each do |c|
  #     @activity.city     = c["long_name"]  if c["types"].include? "locality"
  #     @activity.zip_code = c["long_name"]  if c["types"].include? "postal_code"
  #     @activity.state    = c["short_name"] if c["types"].include? "administrative_area_level_1"
  #     @activity.country  = c["long_name"]  if c["types"].include? "country"
  #   end
  # end

  # def set_coordinates
  #   @activity.latitude  = @api_details.data["geometry"]["location"]["lat"]
  #   @activity.longitude = @api_details.data["geometry"]["location"]["lng"]
  # end

  # def full_address
  #   "#{@activity.title}, #{@activity.street}"
  # end

end
