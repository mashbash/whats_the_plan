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
    waypoints = [best_route[1].gmaps_string, best_route[2].gmaps_string]
    gmaps({ "direction" =>
            { "data"      =>
              { "from" => best_route.first.gmaps_string,
                "to"   => best_route.last.gmaps_string},
                "options" => {"travelMode" => "DRIVING", "waypoints" => waypoints} }
          })
  end

  def city(plan)
    plan.activities.first.city
  end  

end
