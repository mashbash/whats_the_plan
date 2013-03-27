module PlansHelper

  def time_slot_title(index)
    ["MORNING ACTIVITY (9am - Noon)", "LUNCH",
     "AFTERNOON ACTIVITY (1:30pm - 5:00pm)", "DINNER"][index]
  end

  def title(activity)
    activity ? activity.title : "Placeholder"
  end

  def street(activity)
    activity.street
  end

  def city_state(activity)
    "#{activity.city}, #{activity.state} #{activity.zip_code}"
  end

  def map(best_route)
    best_route = best_route.delete_if { |activity| activity.nil? }

    gmaps({ "direction" =>
            { "data"      =>
              { "from" => best_route.first.gmaps_string,
                "to"   => best_route.last.gmaps_string},
                "options" => {"waypoints" => waypoints(best_route), "travelMode" => "DRIVING", 
                              "avoidHighways" => TRUE} }
          })
  end

  def waypoints(best_route)
    waypoints = best_route[1..-2].map do |activity|
      activity.gmaps_string
    end
  end

  def city(plan)
    plan.activities.first.city
  end

  def distances_between_activities(plan)
    coords = coordinates(plan.best_route.include?(nil) ? plan.best_route.compact! : plan.best_route )
    distances = []
    (coords.length - 1).times do |i|
      distances << (distance_between(coords[i], coords[i+1]) * 1.2).round(1)
    end
    distances
  end  

  def coordinates(route)
    route.map { |activity| activity.to_coordinates }
  end

  def distance_between(from, to)
    Geocoder::Calculations.distance_between(from, to)
  end
end



