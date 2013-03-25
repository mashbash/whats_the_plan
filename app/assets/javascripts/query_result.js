var queryResult = {
  activities: [],

  init: function() {
    this.$body = $('.search-results');
  },

  load: function(data, isMeal) {
    this.activities = [];
    for (i in data) {
      var activity = new Activity(data[i], i);
      activity.meal = isMeal;
      this.activities.push(activity);
    }
    this.render();
    this.activityListener();
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
    $('.search-results .activity-block').remove();
    for (i in this.activities) {
      this.$body.append(this.activities[i].renderSearch());
    }
  },

  activityListener: function() {
    var self = this;
    $('.add-to-plan').on('click', function(e){
      e.preventDefault();
      var searchId = $(this).parents('.activity-block').data('id')
      var activity = self.find(searchId);
      plan.add(activity);
      self.remove(searchId);
      $(this).parents('.activity-block').remove();
    });
  },
};

