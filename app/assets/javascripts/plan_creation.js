jQuery(document).ready(function($) {
  homepage.init(window.location.pathname);

  $('#destination').focus();
  form.init();
  plan.init();
  queryResult.init();

  planProcessor.init();

  $('tr.row-link').on('click', function(){
    var linkTo = $(this).find('td a').attr('href');
    window.location.href = linkTo;
  });
});
