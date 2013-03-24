var queryResult = {
  activities: [],

  init: function() {

  },

  load: function(data) {
    for (i in data) {
      this.activities.push(new Activity(data[i]));
    }
    this.render();
  },

  render: function(activity) {
    // $('.new-plan').append(activity.render());
    // if (activity.meal) $('.new-activity').last().addClass("meal");
    // this.activityListener();
  },

  activityListener: function() {
    // var self = this;
    // $('.new-close-icon').on('click', function(e){
    //   e.preventDefault();
    //   $(this).parents('.new-activity').remove();
    // });
  },
};

