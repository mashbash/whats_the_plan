var planProcessor = {
  showRegex: new RegExp(/\/plans\/\d+$/),

  init: function(location) {
    if ( this.showRegex.test(location) && $('h1#processing').length > 0 ) {
      this.pollPlans();
    }
  },

  pollPlans: function() {
    var self = this;
    var path = window.location.pathname;
    $.get(path + "/refresh", function(data){

      if (data.sequenced) {
        window.location.href = path
      } else {
        setTimeout(planProcessor.pollPlans, 3000);
      }
    });
  },
}