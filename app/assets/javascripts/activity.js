function Activity(data, id) {
  this.id = id;
  this.destination = data.destination;
  this.address = data.address;
  this.meal = data.meal;
  this.yelpUrl = data.yelp_url;
  this.image = data.image;
  this.ratingImg = data.rating_img;
  this.lat = data.latitude;
  this.lng = data.longitude;
  this.street = data.street;
  this.city   = data.city;


  this.get_location_data();
};

Activity.prototype.renderPlan = function() {
  return JST["templates/activity_plan_block"](this);
};

Activity.prototype.renderSearch = function() {
  return JST["templates/activity_search_block"](this);
};

Activity.prototype.params = function() {
  return {title: this.destination, meal: this.mealVal(), street: this.address, latitude: this.lat, longitude: this.lng, image_url: this.image}
};

Activity.prototype.mealVal = function() {
  if (this.meal){
    return 1;
  } else {
    return 0;
  }
};

Activity.prototype.element = function() {
  $("div[data-id='" + this.id +"']");
}

Activity.prototype.get_location_data = function() {
  var activity = this;
  geocoder = new google.maps.Geocoder();
  geocoder.geocode( { 'address': this.destination + this.address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      debugger
      activity.set_location_data(results);
    } else {
      activity.address = "no results";
    }
  });
};

Activity.prototype.set_location_data = function(results) {
  this.lat = results[0].geometry.location.hb;
  this.lng = results[0].geometry.location.ib;
  this.address = results[0].formatted_address;
};
