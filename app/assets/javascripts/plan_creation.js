jQuery(document).ready(function($) {
  $('#destination').focus();
  form.init();
  plan.init();
  queryResult.init();

  $('tr.row-link').on('click', function(){
    var linkTo = $(this).find('td a').attr('href');
    window.location.href = linkTo;
  });

  setTimeout( doneProcessing, 1000 );
});
