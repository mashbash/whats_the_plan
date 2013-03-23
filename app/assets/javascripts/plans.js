jQuery(document).ready(function($) {
  $('a.add-activity').on('click', function(e){
    e.preventDefault();
    var template = JST["templates/activity_form"]({id: $('.activity-form').length});
    $('.activity-form-container').append(template);
  });
});
