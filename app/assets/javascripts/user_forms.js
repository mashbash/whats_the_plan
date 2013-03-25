$(document).ready(function() {
  $('.signup').on('click', function(e){
    e.preventDefault();
    $('.signin-form').hide();
    $('.signup-form').slideToggle();
    console.log("i'm here! in signup!");
  });

  $('.signin').on('click', function(e){
    e.preventDefault();
    $('.signup-form').hide();
    $('.signin-form').show();
  });

  // if ($('.signup-form ul.errors li').length > 0) $('.signup-form').show();
  // if ($('.signin-form ul.errors li').length > 0) $('.signin-form').show();
});
