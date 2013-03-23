class ActivityCluster
  MAX_ROUTE_LENGTH = 4
  MAX_DISTANCE     = 2000

  def initialize(destinations)
    raise ArgumentError unless destinations.is_a?(Array) && destinations.any?
    @destinations  = destinations
  end

  def best_cluster_and_route
    nonmeal_dest = partition_destinations.first
    best_route = Route.new(shortest_route(nonmeal_dest.shift))
    nonmeal_dest.each do |dest|
      route = Route.new(shortest_route(dest))
      best_route = best_route.preferred(route)
    end

    best_route
  end

  def shortest_route(starting_point)
    nonmeal_dest, meal_dest = partition_destinations(starting_point)
    route = starting_point.nil? ? [nil, meal_dest.shift] : [starting_point]

    until route.length == MAX_ROUTE_LENGTH do
      active_destinations = route.length.even? ? nonmeal_dest : meal_dest
      next_destination = closest_location(last_valid_location(route), active_destinations)

      if next_destination
        route << active_destinations.slice!(active_destinations.index(next_destination))
      else
        route << next_destination
      end
    end

    route
  end

  def closest_location(location, destinations)
    return nil if destinations.empty?   
    distances = destinations.map do |destination|
      {location: destination, distance: self.distance_between(location, destination)}
    end
    
    closest = distances.sort{|a, b| a[:distance] <=> b[:distance]}.first
    closest[:location] unless closest[:distance] > MAX_DISTANCE
  end

  def distance_between(location, destination)
    Geocoder::Calculations.distance_between(location, destination)
  end

  def partition_destinations(starting_point = nil)
    (@destinations-[starting_point]).partition {|dest| dest.meal.zero? }
  end

  private 
  def last_valid_location(route)
    route.reverse.find{ |r| r }
  end
end
