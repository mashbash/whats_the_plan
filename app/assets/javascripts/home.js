jQuery(document).ready(function($) {
  $('.singapur-plans').hide();
  $('.sanfrancisco-plans').hide();
  $('.icon-angle-right').on('click', function(){
    if ($('body').hasClass('homepage-berlin')) {
      // $('body').switchClass("homepage-berlin", "homepage-singapur");
      $('body').removeClass('homepage-berlin');
      $('.berlin-plans').hide('slow');
      $('.singapur-plans').show('slow');
      $('body').addClass('homepage-singapur');
    } else if ($('body').hasClass('homepage-singapur')) {
      $('body').removeClass('homepage-singapur');
      $('body').addClass('homepage-sanfrancisco');
      $('.singapur-plans').hide('slow');
      $('.sanfrancisco-plans').show('slow');
    } else if ($('body').hasClass('homepage-sanfrancisco')) {
      $('body').removeClass('homepage-sanfrancisco');
      $('body').addClass('homepage-berlin');
      $('.sanfrancisco-plans').hide('slow');
      $('.berlin-plans').show('slow');
    }; 
  });
  $('.icon-angle-left').on('click', function(){
    if ($('body').hasClass('homepage-berlin')) {
      $('body').removeClass('homepage-berlin');
      $('body').addClass('homepage-sanfrancisco');
      $('.berlin-plans').hide('slow');
      $('.sanfrancisco-plans').show('slow');
    } else if ($('body').hasClass('homepage-singapur')) {
      $('body').removeClass('homepage-singapur');
      $('body').addClass('homepage-berlin');
      $('.singapur-plans').hide('slow');
      $('.berlin-plans').show('slow');
    } else if ($('body').hasClass('homepage-sanfrancisco')) {
      $('body').removeClass('homepage-sanfrancisco');
      $('body').addClass('homepage-singapur');
      $('.sanfrancisco-plans').hide('slow');
      $('.singapur-plans').show('slow');
    }; 
  });
});

