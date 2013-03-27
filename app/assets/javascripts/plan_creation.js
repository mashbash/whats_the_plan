jQuery(document).ready(function($) {
  $('#destination').focus();
  form.init();
  plan.init();
  queryResult.init();

  $('tr').on('click', function(){
    var linkTo = $(this).find('td a').attr('href');
    window.location.href = linkTo;
  });

  var matchLink = new RegExp(/sign_in|sign_up|users$/);
  if (matchLink.test(window.location.pathname)) {
    $('.show-signup').hide();
    $('.show-signin').hide();
  };

  $('.show-signup').on('click', function(e){
    e.preventDefault();
    $('.signin-form').hide();
    $('.signup-form').slideToggle();
  });

  $('.show-signin').on('click', function(e){
    e.preventDefault();
    $('.signup-form').hide();
    $('.signin-form').show();
  });
});
