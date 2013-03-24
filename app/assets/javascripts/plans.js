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
    $('.new-close-icon').on('click', function(e){
      e.preventDefault();
      $(this).parents('.new-activity').remove();
    });

    // $('.create-plan').on('click', function(e){
    //   $.post("/plans", )
  },

  submit: function() {
    //send data to server 
    //redirect
  },
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
    var mealVal = $('div.switch-on').length == 1;
    return {destination: this.destination.val(), address: this.address.val(), meal: mealVal};
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

jQuery(document).ready(function($) {
  $('#title').focus(); 
  form.init();
});
