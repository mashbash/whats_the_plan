$(document).ready(function() {
  $('tr').on('click', function(){
  var linkTo = $(this).find('td a').attr('href'); 
  window.location.href = linkTo;
  });
});

