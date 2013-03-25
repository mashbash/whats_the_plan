class YelpResult
  attr_reader :destination, :image, :latitude, :longitude, :yelp_url

  def initialize(args)
    @destination = args["name"]
    @yelp_url    = args["url"]
    @image       = args["image_url"]
    @rating_img  = args["rating_img_url_small"]
    @address     = shorten_address(args["location"])
    @latitude, @longitude = set_coordinates(args["location"]["coordinate"])
  end

  def set_coordinates(coords)
    [coords["latitude"], coords["longitude"]]
  end

  def self.load(results)
    results.map { |data| YelpResult.new(data) }
  end

  def shorten_address(args)
    "#{args["display_address"].first}\n#{args["display_address"].last}"
  end
end
