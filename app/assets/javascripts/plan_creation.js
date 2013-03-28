jQuery(document).ready(function($) {
  $('#destination').focus();
  form.init();
  plan.init();
  queryResult.init();
  // planProcessor.init(window.location.pathname);

  $('tr').on('click', function(){
    var linkTo = $(this).find('td a').attr('href');
    window.location.href = linkTo;
  });

  var showRegex = new RegExp(/\/plans\/\d+$/);
  if (showRegex.test(window.location.pathname)) {
    if ($('h1#processing').length > 0) {
      pollPlans();
    }
  };

  function pollPlans(path) {
    path = window.location.pathname;
    $.get(path + "/refresh", function(data){
      if (data.sequenced) {
        window.location.href = path
      } else {
        setTimeout(pollPlans, 5000);
      }
    });
  }
});
