var plan = {
  activities: [],

  init: function() {
  this.planFormListener();
  },

  add: function(activity) {
    this.activities.push(activity);
    this.render(activity);
    $('.create-plan').attr('disabled', false);
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

  render: function(activity) {
    $('.new-plan').append(activity.renderPlan());
    this.activityListener();
  },

  activityListener: function() {
    var self = this;
    $('.new-close-icon').on('click', function(e){
      e.preventDefault();
      var id = $(this).parents('.new-activity').data('id')
      plan.remove(id);
      $(this).parents('.new-activity').remove();
    });
  },

  planFormListener: function() {
    var self = this;
    $('.create-plan').on('click', function(e){
      e.preventDefault();
      $.post("/plans", self.params(), "json").done(function(data){
        // need to handle error response cases
        window.location.href = "/plans/" + data.plan.id;
      });
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
