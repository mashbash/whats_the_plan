module PlansHelper

  def title(activity)
    activity ? activity.title : "Placeholder"
  end

  def street(activity)
    if activity
      activity.street == " " ? activity.city : activity.street
    else
      "Nearby"
    end
  end

  def meal(index)
    (index % 2).zero? ? "Activity" : "Meal"
  end

  def map(best_route)
    best_route = best_route.delete_if { |activity| activity.nil? }
  
    gmaps({ "direction" =>
            { "data"      =>
              { "from" => best_route.first.gmaps_string,
                "to"   => best_route.last.gmaps_string},
                "options" => {"travelMode" => "DRIVING", "waypoints" => waypoints(best_route) } }
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

  def distance_between(from, to)
    Geocoder::Calculations.distance_between(from, to)
  end
end
