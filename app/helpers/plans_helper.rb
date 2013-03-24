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

  def map_url
    'http://maps.google.com/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=717+California+Street,+San+Francisco,+CA&amp;aq=0&amp;oq=717+california+st&amp;sll=37.831261,-122.469285&amp;sspn=0.220998,0.32032&amp;ie=UTF8&amp;hq=&amp;hnear=717+California+St,+San+Francisco,+California+94108&amp;t=m&amp;z=14&amp;ll=37.79221,-122.406141&amp;'
  end  

  def map_embedded_url
    'http://maps.google.com/maps?saddr=717+California+Street,+San+Francisco,+CA+to:Muir+Woods+National+Monument,+Mill+Valley,+CA+to:Golden+Gate+Park,+San+Francisco,+CA+to:Treasure+Island,+San+Francisco,+CA&amp;ie=UTF8&amp;t=m&amp;geocode=FdKpQAIdAzu0-ClfcJGQi4CFgDHEcy9GRGYI9Q%3BFV8uQgIdKb6x-CH5r_9odlj_eimtYme9tJGFgDH5r_9odlj_eg%3BFVBPQAIdwQyz-CnjMipXcoeFgDHAC5zWYXaThw%3BFdghQQIdK8e0-CkJavwhM4CFgDHehD0btWC32g&amp;ll=37.831261,-122.469285&amp;spn=0.130625,0.205064&amp;output=embed'
  end

  def map_source_url
    'http://maps.google.com/maps?saddr=717+California+Street,+San+Francisco,+CA+to:Muir+Woods+National+Monument,+Mill+Valley,+CA+to:Golden+Gate+Park,+San+Francisco,+CA+to:Treasure+Island,+San+Francisco,+CA&amp;ie=UTF8&amp;t=m&amp;geocode=FdKpQAIdAzu0-ClfcJGQi4CFgDHEcy9GRGYI9Q%3BFV8uQgIdKb6x-CH5r_9odlj_eimtYme9tJGFgDH5r_9odlj_eg%3BFVBPQAIdwQyz-CnjMipXcoeFgDHAC5zWYXaThw%3BFdghQQIdK8e0-CkJavwhM4CFgDHehD0btWC32g&amp;ll=37.831261,-122.469285&amp;spn=0.130625,0.205064&amp;source=embed'
  end



end
