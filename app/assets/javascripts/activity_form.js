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
      plan.add(new Activity(self.data(), plan.activities.length + 1));
      self.reset();
    });

    $('.yelp-search').on('click', function(e) {
      e.preventDefault();
      if(self.invalid()) return false

      var searchTerms = {};
      $.post("/yelp", {query: searchTerms}).done(function(data){
        queryResult.load(data.results);
      }); 
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
