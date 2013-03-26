module PlansHelper

  def time_slot_title(index)
    ["MORNING ACTIVITY (10am - Noon)", "LUNCH",
     "AFTERNOON ACTIVITY (2:00pm - 4:00pm)", "DINNER"][index]
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
