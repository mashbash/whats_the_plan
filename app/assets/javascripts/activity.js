function Activity(data, id) {
  this.id = id;
  this.address   = data.address;
  this.destination = data.destination;
  this.meal      = data.meal;
  this.yelpUrl   = data.yelp_url;
  this.image     = this.setImage(data.image);
  this.ratingImg = data.rating_img;
  this.street    = data.street;
  this.city      = data.city;
  this.state     = data.state;
  this.zip_code  = data.zip_code;
  this.lat = data.latitude;
  this.lng = data.longitude;
  this.displayCity = [this.city, this.state, this.zip_code].join(", ");
};

Activity.prototype.renderPlan = function() {
  return JST["templates/activity_plan_block"](this);
};

Activity.prototype.renderSearch = function() {
  return JST["templates/activity_search_block"](this);
};

Activity.prototype.params = function() {
  return {title:     this.destination,
          meal:      this.mealVal(),
          street:    this.street,
          city:      this.city,
          state:     this.state,
          country:   this.country,
          zip_code:  this.zip_code,
          latitude:  this.lat,
          longitude: this.lng,
          image_url: this.image}
};

Activity.prototype.updateStreet = function() {
  if (this.street_num) {
    return this.street_num + " " + this.street_name;
  } else if (this.street_name) {
    return this.street_name;
  } else {
    return "Street not found";
  }
};

Activity.prototype.updateCity = function() {
  this.displayCity = [this.city, this.state, this.zip_code].join(" ");
  return this.displayCity;
};

Activity.prototype.mealVal = function() {
  if (this.meal){
    return 1;
  } else {
    return 0;
  }
};

Activity.prototype.get_location_data = function() {
  var activity = this;
  geocoder = new google.maps.Geocoder();
  geocoder.geocode( { 'address': activity.destination + ", " + activity.address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      activity.set_location_data(results);
    } else {
      activity.address = "no results";
    }
    activity.parseAddress(results)
  });
};

Activity.prototype.set_location_data = function(results) {
  this.lat = results[0].geometry.location.hb;
  this.lng = results[0].geometry.location.ib;
};

Activity.prototype.parseAddress = function(results) {
  var address = results[0].address_components
  for (i in address) {
    if(address[i].types == "street_number") {
      this.street_num = address[i].long_name;
    }
    else if (address[i].types == "route") {
      this.street_name = address[i].long_name;
    }
    else if (address[i].types[0] == "locality") {
      this.city = address[i].long_name;
    }
      else if (address[i].types == "postal_code") {
      this.zip_code = address[i].long_name;
    }
    else if (address[i].types[0] == "administrative_area_level_1") {
      this.state = address[i].short_name;
    }
    else if (address[i].types[0] == "country") {
      this.country = address[i].short_name;
    };
  }
  this.street = this.updateStreet();
  this.triggerGeocode();
};

Activity.prototype.triggerGeocode = function() {
  var $element = $(".search-results .activity-block[data-id='" + this.id + "']");
  $element.trigger("geocoded", {street: this.street, city: this.updateCity()});
};

Activity.prototype.setImage = function(image) {
  if (image == undefined) {
    return "http://" + this.destination.replace(/\s+/g, '') + ".jpg.to/icon"
  } else {
    return image;
  }
};