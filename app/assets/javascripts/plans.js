var plan = {
  activities: [],

  add: function(activity) {
    this.activities.push(activity);
    this.render(activity);
  },

  render: function(activity) {
    $('.new-plan').append(activity.render());
    if (activity.meal) $('.new-activity').last().addClass("meal");
    this.listen();
  },

  listen: function() {
    var self = this;
    $('.new-close-icon').on('click', function(e){
      e.preventDefault();
      $(this).parents('.new-activity').remove();
    });

    $('.create-plan').on('click', function(e){
      $.post("/plans", self.params(), "json").done(function(){});
    });
  },

  params: function() {
    return {plan: { title: this.title(), activities_attributes: this.activitesAttrs()} }
  },

  activitesAttrs: function() {
    var data = {}
    for (i in this.activities) {
      var key = (i).toString();
      data[key] = this.activities[i].params();
    }
    return data;
  },

  title: function() {
    return $('#title').val();
  }
};

var form = {
  init: function() { 
    this.destination = $('#destination');
    this.address = $('#address');
    this.listen();
  },

  listen: function() {
    var self = this;
    $('.add-activity').on('click', function(e){
      e.preventDefault();
      if (self.invalid()) return false

      $('div.new-plan, .create-plan').show();
      plan.add(new Activity(self.data()));
      self.reset();
    });
  },

  invalid: function() {
    $.each($('#destination, #address'), function(idx, input){
      if ($(input).val() == "") $(input).addClass("error");
    });   
    return ($('#destination').val() == "") || ($('#address').val() == "");
  },

  data: function() {
    var mealBool = $('div.switch-on').length == 1;
    return {destination: this.destination.val(), address: this.address.val(), meal: mealBool};
  },

  reset: function() {
    $('#destination, #address').val("");
    $('#destination').focus(); 
    $('input').removeClass('error');
  }
};

function Activity(data) {
  this.destination = data.destination;
  this.address = data.address;
  this.meal = data.meal;
};

Activity.prototype.render = function() {
  return JST["templates/new_activity"](this.attrs());
};

Activity.prototype.attrs = function() {
  return {destination: this.destination, meal: this.meal, address: this.address}
};

Activity.prototype.params = function() {
  return {destination: this.destination, meal: this.mealval(), address: this.address}
};

Activity.prototype.mealVal = function() {
  if (this.meal){
    return 1;
  } else {
    return 0;
  }
};



jQuery(document).ready(function($) {
  $('#title').focus(); 
  form.init();
});
