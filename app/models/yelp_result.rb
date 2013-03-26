class YelpResult
  attr_reader :destination, :image, :latitude, :longitude, :yelp_url

  def initialize(args)
    @destination = args["name"]
    @yelp_url    = args["url"]
    @image       = args["image_url"]
    @rating_img  = args["rating_img_url_small"]
    @street      = args["location"]["address"].first
    @city        = args["location"]["city"]
    @state       = args["location"]["state_code"]
    @zip_code    = args["location"]["postal_code"]
    @country     = args["location"]["country_code"]
    @display_city   = args["location"]["display_address"].last
    @latitude, @longitude = set_coordinates(args["location"]["coordinate"])
  end

  def set_coordinates(coords)
    [coords["latitude"], coords["longitude"]]
  end

  def self.load(results)
    results.map { |data| YelpResult.new(data) }
  end
end
