var queryResult = {
  activities: [],

  init: function() {
    this.$body = $('.search-results');
    this.activityListener();
  },

  load: function(data, isMeal) {
    var activityCount = this.activities.length;
    for (i in data) {
      var id = parseInt(i) + activityCount;
      var activity = new Activity(data[i], id);
      activity.meal = isMeal;
      this.activities.push(activity);
    }
    this.render();
  },

  add: function(activity) {
    activity.id = this.activities.length;
    this.activities.push(activity);
    this.render();
  },

  remove: function(id) {
    var activity = this.find(id);
    this.activities.splice(this.activities.indexOf(activity), 1);
  },

  find: function(id) {
    for (i in this.activities) {
      if (this.activities[i].id == id) return this.activities[i];
    }
  },

  render: function() {
    $('.yelp-label').remove();
    $('.search-results .activity-block').remove();
    for (i in this.activities) {
      if (this.activities[i].id == 1) {
        this.$body.append(JST["templates/yelp_label"]());
      }
      this.$body.append(this.activities[i].renderSearch());
    }
    $('a[href=""]').addClass('disabled');
  },

  activityListener: function() {
    var self = this;
    $('.search-results').on('click', '.add-to-plan', function(e){
      e.preventDefault();
      var newActivity = self.find($(this).parents('.activity-block').data('id'))
      self.remove(newActivity.id);
      plan.add(newActivity);
      $(this).parents('.activity-block').remove();
    });

    $('.search-results').on('geocoded', ".activity-block", function(event, data){
      $(this).children('.activity-details').append("<div class='activity-street'>"+data.street+"</div>");
      $(this).children('.activity-details').append("<div class='activity-city'>"+data.city+"</div>");
    });
  },

  reset: function() {
    this.activities = [];
  }
};

