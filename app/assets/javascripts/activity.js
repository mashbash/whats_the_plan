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
};

Activity.prototype.renderPlan = function() {
  return JST["templates/activity_plan_block"](this);
};

Activity.prototype.renderSearch = function() {
  return JST["templates/activity_search_block"](this);
};

Activity.prototype.params = function() {
  return {title: this.destination, meal: this.mealVal(), street: this.address, latitude: this.lat, longitude: this.lng}
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
