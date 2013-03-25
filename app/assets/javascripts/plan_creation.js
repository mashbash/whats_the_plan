jQuery(document).ready(function($) {
  $('#title').focus();
  form.init();
  plan.init();
  queryResult.init();

  $('tr').on('click', function(){
    var linkTo = $(this).find('td a').attr('href');
    window.location.href = linkTo;
  });
});
