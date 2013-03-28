var form = {
  init: function() {
    this.destination = $('#destination');
    this.address = $('#address');
    this.listen();
    $('.plan-builder').hide();
  },

  listen: function() {
    var self = this;
    $('.add-activity').on('click', function(e){
      e.preventDefault();
      $('.demo').hide();
      $('.plan-builder').fadeIn();
      if (self.invalid()) return false

      $('.search-results .activity-block').remove();
      queryResult.reset();
      $('div.new-plan, .create-plan').fadeIn();
      self.fetch();
      self.reset();
    });
  },

  geocode: function() {
    var newActivity = new Activity(this.data());
    newActivity.get_location_data();
    queryResult.add(newActivity);
  },

  fetch: function() {
    var self = this;
    self.geocode();

    var searchTerms = { destination: self.destination.val(), address: self.address.val() };
    $.post("/yelp", {query: searchTerms}).done(function(data){
      if (data.results.error == undefined) {
        queryResult.load(data.results, self.isMeal());
        queryResult.render();
      } else {
        queryResult.renderNoResults();
      }
    });
  },

  invalid: function() {
    $.each($('#destination, #address'), function(idx, input){
      if ($(input).val() == "") $(input).addClass("error");
    });
    return ($('#destination').val() == "") || ($('#address').val() == "");
  },

  data: function() {
    var mealBool = this.isMeal();
    return {destination: this.destination.val(), address: this.address.val(), meal: mealBool};
  },

  reset: function() {
    $('#destination').focus();
    $('input').removeClass('error');
  },

  isMeal: function() {
    return $('#meal')[0].checked;
  }
};
