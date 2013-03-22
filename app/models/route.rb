class Route

  attr_reader :destinations

  def initialize(destinations)
    raise ArgumentError unless destinations.is_a?(Array) && destinations.any?
    @destinations = destinations
  end

  def total_distance
    total = 0
    (valid_destinations.length - 1).times do |idx|
      total += distance_between(valid_destinations[idx], valid_destinations[idx + 1])
    end
    total
  end

  def dest_count
    @destinations.count{ |destination| destination }
  end

  def preferred(other_route)
    raise ArgumentError unless other_route.is_a? Route
    
    return fewer_dests(other_route) unless self.dest_count == other_route.dest_count
    shorter_route(other_route)
  end

  private
  def distance_between(location, destination)
    Geocoder::Calculations.distance_between(location, destination)
  end

  def valid_destinations
    @valid_destinations ||= @destinations.find_all { |dest| dest }
  end

  def fewer_dests(other_route)
    if self.dest_count > other_route.dest_count
      return self
    elsif other_route.dest_count > self.dest_count
      return other_route
    end
  end

  def shorter_route(other_route)
    self.total_distance > other_route.total_distance ? other_route : self
  end
end
