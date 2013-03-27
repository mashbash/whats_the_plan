jQuery(document).ready(function($) {
  $('#destination').focus();
  form.init();
  plan.init();
  queryResult.init();

  $('tr').on('click', function(){
    var linkTo = $(this).find('td a').attr('href');
    window.location.href = linkTo;
  });

  setTimeout( doneProcessing, 1000 );

  function doneProcessing() {
    if ($('h1#processing').html()=="Calculating best route. Please reload in a few seconds") {
      window.location.reload(true);
    }
  }

});
