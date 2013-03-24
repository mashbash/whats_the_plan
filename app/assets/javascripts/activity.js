function Activity(data) {
  this.destination = data.destination;
  this.address = data.address;
  this.meal = data.meal;
  this.yelpUrl = data.yelp_url;
  this.image = data.image;
  this.ratingImg = data.rating_img;
  this.lat = data.latitude;
  this.lng = data.longitude;
};

Activity.prototype.render = function() {
  return JST["templates/new_activity"](this.attrs());
};

Activity.prototype.attrs = function() {
  return {destination: this.destination, meal: this.meal, address: this.address}
};

Activity.prototype.params = function() {
  return {title: this.destination, meal: this.mealVal(), street: this.address}
};

Activity.prototype.mealVal = function() {
  if (this.meal){
    return 1;
  } else {
    return 0;
  }
};
