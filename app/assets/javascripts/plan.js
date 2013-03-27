 var plan = {

  activities: [],

  init: function() {
    this.planFormListener();
  },

  add: function(activity) {
    activity.id = this.nextId();
    this.activities.push(activity);
    this.render(activity);
    $('.create-plan').removeClass('disabled');
  },

  nextId: function() {
    if (this.activities.length == 0) {
      return 0;
    } else {
      return this.activities[this.activities.length -1].id + 1;
    }
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
    this.activityListener(activity.id);
    $('a[href=""]').addClass('disabled');
  },

  activityListener: function(id) {
    var self = this;
    $(".new-plan div[data-id='" + id + "']").on('click', '.new-close-icon', function(e){
      e.preventDefault();
      var id = $(this).parents('.activity-block').data('id');
      plan.remove(id);
      $(this).parents('.activity-block').remove();
      if (self.activities.length == 0) {
        $('.create-plan').addClass('disabled');
      };
    });
  },

  planFormListener: function() {
    var self = this;
    $('.create-plan').on('click', function(e){
      e.preventDefault();
      if (self.invalid()) return false;
      $.post("/plans", self.params(), "json").done(function(data){
        // need to handle error response cases
        window.location.href = "/plans/" + data.plan.id;
      });
    });

    $('.new-plan').on('geocoded', ".activity-block", function(event, data){
      $(this).children('.activity-details').append("<div class='activity-street'>"+data.street+"</div>");
      $(this).children('.activity-details').append("<div class='activity-city'>"+data.city+"</div>");
    });
  },

  invalid: function() {
    if ($('#title').val() == "") $('#title').addClass("error");
    return ($('#title').val() == "");
  },

  params: function() {
    return {plan: { title: this.title(), activities_attributes: this.activitiesAttrs()} }
  },

  activitiesAttrs: function() {
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
