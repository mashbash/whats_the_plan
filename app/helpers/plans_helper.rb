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

end
