jQuery(document).ready(function($) {
  $('#destination').focus();
  form.init();
  plan.init();
  queryResult.init();
  planProcessor.init(window.location.pathname);
  homepage.init();

  $('tr.row-link').on('click', function(){
    var linkTo = $(this).find('td a').attr('href');
    window.location.href = linkTo;
  });
});
